class Finding < ActiveRecord::Base
  attr_accessible :category, :corrective_action, :date_created, :description, 
                  :preventive_action, :risk_rating, :audit_id, :department_name, :category_name, 
                  :risk_name, :status_name, :status_id,
                  :documents_attributes, :iso_clause, :closure_date  #, :documents#,:avatar
  belongs_to :audit
  belongs_to :finding_type
  belongs_to :risk
  belongs_to :finding_status
  # belongs_to :document
   has_many :documents, :dependent => :destroy
  validates :closure_date, :date => {:after_or_equal_to => Time.now, :message => 'must be after or same as created date' }
  validates_presence_of :corrective_action, :if => Proc.new { |finding| finding.status_id == "Under review" || finding.status_id == "Closed"} ,:message => "Please enter CAPA before you change the status to Under Review"
#  has_attached_file :avatar #, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  accepts_nested_attributes_for :documents , :allow_destroy => true
  
end


