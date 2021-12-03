class CreateSensorMesurements < ActiveRecord::Migration[6.0]
  def change
    create_table :sensor_mesurements do |t|
      t.references :sensor, null: false, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
