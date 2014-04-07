class ChangeDateTypeInAudits < ActiveRecord::Migration
  def up
      change_column :audits, :start_date, :datetime
      change_column :audits, :end_date, :datetime
  end

  def down
      change_column :audits, :start_date, :date
      change_column :audits, :end_date, :date
  end
end
