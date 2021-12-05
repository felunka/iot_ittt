class CreateItttConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :ittt_conditions do |t|
      t.references :ittt, null: false, foreign_key: true
      t.references :sensor_1, null: false, foreign_key: { to_table: :sensors }
      t.references :sensor_2, null: true, foreign_key: { to_table: :sensors }
      t.float :comparison_value
      t.integer :operation, default: 0, null: false

      t.timestamps
    end
  end
end
