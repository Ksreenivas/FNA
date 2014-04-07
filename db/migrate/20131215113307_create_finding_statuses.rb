class CreateFindingStatuses < ActiveRecord::Migration
  def change
    create_table :finding_statuses do |t|
      t.string :status_name
      t.string :string

      t.timestamps
    end
  end
end
