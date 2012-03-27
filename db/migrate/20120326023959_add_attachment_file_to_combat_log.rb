class AddAttachmentFileToCombatLog < ActiveRecord::Migration
  def self.up
    add_column :combat_logs, :file_file_name, :string
    add_column :combat_logs, :file_content_type, :string
    add_column :combat_logs, :file_file_size, :integer
    add_column :combat_logs, :file_updated_at, :datetime
  end

  def self.down
    remove_column :combat_logs, :file_file_name
    remove_column :combat_logs, :file_content_type
    remove_column :combat_logs, :file_file_size
    remove_column :combat_logs, :file_updated_at
  end
end
