class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.integer :combat_log_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
