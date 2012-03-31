class AddOwnerIdToEncounters < ActiveRecord::Migration
  def change
    add_column :encounters, :owner_id, :integer

  end
end
