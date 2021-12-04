namespace :rest_sensors do
  require 'rest-client'
  require 'jsonpath'

  desc 'Update REST sensors, if last measurement is older than interval'
  task update_mesurements: :environment do
    sensors_due = Sensor.joins(%(
      LEFT JOIN sensor_measurements measurement ON (
        sensors.id = measurement.sensor_id
        AND NOT EXISTS (
          SELECT 1 FROM sensor_measurements measurement1
          WHERE measurement1.sensor_id = sensors.id
          AND measurement1.created_at > measurement.created_at
        )
      )
    )).where(sensor_type: :rest)
    .where('(measurement.id IS NULL OR EXTRACT(EPOCH FROM (now() - measurement.created_at)) > (sensors.interval * 60))')
    
    sensors_due.each do |sensor|
      result = RestClient.get sensor.url
      json = JSON.parse result.body

      value = JsonPath.on json, sensor.json_path
      begin
        value = Float(value[0])
        mesurement = SensorMeasurement.create sensor: sensor, value: value

        ActionCable.server.broadcast 'measurements',
          sensor_id: sensor.id,
          time: mesurement.created_at,
          value: mesurement.value,
          value_with_text: mesurement.value_with_text
      rescue ArgumentError
        Rails.logger.debug "Invaid value for REST message on URL '#{sensor.url}': #{json}"
      end
    end
  end
end
