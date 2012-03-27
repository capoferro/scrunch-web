class AddCombatLogIdToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :combat_log_id, :integer

  end
end
