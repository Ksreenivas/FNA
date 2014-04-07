class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :report_name
      t.string :report_tag
      t.string :report_status

      t.timestamps
    end
  end
end
