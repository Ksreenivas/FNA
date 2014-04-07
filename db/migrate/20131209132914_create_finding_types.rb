class CreateFindingTypes < ActiveRecord::Migration
  def change
    create_table :finding_types do |t|
      t.string :category_name
    

      t.timestamps
    end
  end
end
