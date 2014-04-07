class Risk < ActiveRecord::Base
  attr_accessible :risk_name
  belongs_to :finding
end
