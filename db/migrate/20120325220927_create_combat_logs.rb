class CreateCombatLogs < ActiveRecord::Migration
  def change
    create_table :combat_logs do |t|
      t.string :filename

      t.timestamps
    end
  end
end
