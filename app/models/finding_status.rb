class FindingStatus < ActiveRecord::Base
  attr_accessible :status_name, :string
  belongs_to :finding
end
