class CreateFindings < ActiveRecord::Migration
  def change
    create_table :findings do |t|
      t.text :description
      t.string :category
      t.string :risk_rating
      t.date :date_created
      t.text :corrective_action
      t.text :preventive_action
      t.timestamps
      
      
    end
   end
end
