class ChangeCombatLogIdToEncounterIdOnEntities < ActiveRecord::Migration
  def change
    rename_column :entities, :combat_log_id, :encounter_id
  end

end
