class AddJsonPathToSensor < ActiveRecord::Migration[6.0]
  def change
    add_column :sensors, :json_path, :string
  end
end
