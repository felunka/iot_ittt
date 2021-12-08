class SensorMeasurementsController < ApplicationController
  def index
    @sensor = Sensor.find params[:sensor_id]
    @sensor_measurements = @sensor.sensor_measurements.order(created_at: :desc).limit(50)
  end
end
