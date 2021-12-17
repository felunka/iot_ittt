class AddToleranzToSensors < ActiveRecord::Migration[6.0]
  def change
    add_column :sensors, :toleranz, :integer
  end
end
