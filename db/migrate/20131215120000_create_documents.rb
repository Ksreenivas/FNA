class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :finding_id
      t.timestamps
    end
    
    add_index :documents, :finding_id
    add_attachment :documents, :attachment
    add_column :findings, :document_id, :integer
  end
end
