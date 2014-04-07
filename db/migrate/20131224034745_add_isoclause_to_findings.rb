class AddIsoclauseToFindings < ActiveRecord::Migration
  def change
    add_column :findings, :iso_clause, :string
    add_index:findings, :iso_clause
  end
end
