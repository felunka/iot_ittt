class AddTriggerAndResultOutputToIttts < ActiveRecord::Migration[6.0]
  def change
    add_column :ittts, :trigger_on_sensor_update, :boolean, default: false
    add_column :ittt_actions, :send_evaluation_output, :boolean, default: false
  end
end
