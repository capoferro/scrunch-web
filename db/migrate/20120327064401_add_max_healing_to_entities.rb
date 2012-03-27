class AddMaxHealingToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :max_healing, :integer

  end
end
