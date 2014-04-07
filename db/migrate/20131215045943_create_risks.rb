class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.string :risk_name
      t.timestamps
    end
  end
end
