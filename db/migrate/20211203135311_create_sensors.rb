class CreateSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :sensors do |t|
      t.string :name
      t.integer :type
      t.string :topic
      t.string :url
      t.integer :interval

      t.timestamps
    end
  end
end
