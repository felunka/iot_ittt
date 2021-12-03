class ChangeSensorMesurementsToSensorMeasurement < ActiveRecord::Migration[6.0]
  def change
    rename_table :sensor_mesurements, :sensor_measurements
  end
end
