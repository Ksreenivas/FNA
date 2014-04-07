class Audit < ActiveRecord::Base
  attr_accessible :auditee_email, :auditee_name, :auditor_email, :auditor_name, :department_name, :end_date, :start_date, :user_id, :audit_type,:location, :secondry_auditor_name, :secondry_auditor_email
  belongs_to :user
  has_many :findings, :dependent => :destroy
  
  validates :department_name, :auditee_name, :auditee_email, :auditor_name, 
            :auditor_email, :location, :presence => true
            
  validates :start_date, :date => {:before_or_equal_to => :end_date, :message => 'must be before or same as end date' }
  
  self.per_page = 3

  validate :cannot_audit_self

  def cannot_audit_self
    self.errors[:base] << "You can not audit yourself." if self.auditee_email == self.auditor_email
  end
  def self.capa_pending_auto_follow_up
    @audits_capa_pending = []
    @audits = Audit.all
    @audits.each do |audit|
      audit.findings.each do |finding|
        if finding.status_id == "CAPA Pending" || finding.status_id == ""
          @audits_capa_pending << audit
          break
        end
      end
    end
    @audits_capa_pending.each do |audit|
      UserMailer.capa_pending_auto_follow_up(audit,current_user).deliver
    end
     #@user = User.all
     # @user.each do |u|
     #   UsersMailer.weekly_mail(u).deliver
    #end
  end
end



