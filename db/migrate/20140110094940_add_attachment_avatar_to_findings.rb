class AddAttachmentAvatarToFindings < ActiveRecord::Migration
  def self.up
    change_table :findings do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :findings, :avatar
  end
end
