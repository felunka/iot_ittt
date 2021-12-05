class CreateIttts < ActiveRecord::Migration[6.0]
  def change
    create_table :ittts do |t|
      t.string :name
      t.integer :interval
      t.timestamp :last_evaluated_at

      t.timestamps
    end
  end
end
