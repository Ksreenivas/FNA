class CreateAuditors < ActiveRecord::Migration
  def change
    create_table :auditors do |t|
      t.string :name
      t.string :email
      t.integer :audit_id
      t.timestamps
    end
  end
end
