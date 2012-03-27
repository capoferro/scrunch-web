class ChangeMaxHealingAndMaxDamageToStringForSerialization < ActiveRecord::Migration
  def up
    change_column :entities, :max_damage, :string
    change_column :entities, :max_healing, :string
  end

  def down
    change_column :entities, :max_damage, :integer
    change_column :entities, :max_healing, :integer
  end
end
