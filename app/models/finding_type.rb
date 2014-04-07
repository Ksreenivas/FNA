class FindingType < ActiveRecord::Base
  attr_accessible :category_name
  belongs_to :finding
end
