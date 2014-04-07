class AddColumnClosureDateToFindings < ActiveRecord::Migration
  def change
    add_column :findings,:closure_date ,:datetime
  end
end
