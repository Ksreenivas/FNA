class AddAuditTypeToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :audit_type, :string
    add_index:audits, :audit_type
  end
end
