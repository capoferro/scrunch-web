class RemoveFilenameFromCombatLogs < ActiveRecord::Migration
  def change
    remove_column :combat_logs, :filename
  end
end
