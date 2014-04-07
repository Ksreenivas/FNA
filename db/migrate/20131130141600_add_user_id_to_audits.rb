class AddUserIdToAudits < ActiveRecord::Migration
  def change
      add_column:audits, :user_id, :integer
      add_index:audits, :user_id
  end
end
