class AddAuditIdToFindings < ActiveRecord::Migration
  def change
      
      add_column:findings, :audit_id, :integer
      
      add_index:findings, :audit_id
 
  end
end
