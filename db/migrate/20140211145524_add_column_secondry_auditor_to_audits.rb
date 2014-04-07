class AddColumnSecondryAuditorToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :secondry_auditor_name, :string
    add_column :audits, :secondry_auditor_email, :string
  end
end
