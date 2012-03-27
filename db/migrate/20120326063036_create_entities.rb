class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
      t.integer :total_damage
      t.boolean :player
      t.integer :total_healing

      t.timestamps
    end
  end
end
