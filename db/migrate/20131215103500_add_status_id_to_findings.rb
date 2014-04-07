class AddStatusIdToFindings < ActiveRecord::Migration
  def change
      
      add_column:findings, :status_id, :string
      add_index:findings, :status_id
      
  end
end
