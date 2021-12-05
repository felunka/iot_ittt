class CreateItttActions < ActiveRecord::Migration[6.0]
  def change
    create_table :ittt_actions do |t|
      t.references :ittt, null: false, foreign_key: true
      t.string :topic
      t.string :message

      t.timestamps
    end
  end
end
