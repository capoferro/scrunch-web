class AddMaxDamageToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :max_damage, :integer
  end
end
