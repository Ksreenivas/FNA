class Activity < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :user
  belongs_to :targetable, polymorphic: true
end
