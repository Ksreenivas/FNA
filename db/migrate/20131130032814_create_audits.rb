class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.string :department_name
      t.string :auditee_name
      t.string :auditee_email
      t.string :auditor_name
      t.string :auditor_email
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
