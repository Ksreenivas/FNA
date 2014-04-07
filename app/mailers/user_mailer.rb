class UserMailer < ActionMailer::Base
  default :from => "vishant@sreenivas.com"  
  
  def welcome_email(user)  
    mail(:to => user.email, :subject => "Grand welcome to sreenivas!")  
  end  
  
  def assign_audit(audit,email,current_user)
    @audit = audit
    @user = current_user
    mail(:to => email, :subject => "Notification: Mark your calendar, an audit is assigned")  
  end
  
  def assign_auditee(audit,email,current_user)
    @audit = audit
    @user = current_user
    mail(:to => email, :subject => "Notification: Mark your calendar, an audit is assigned ")  
  end
  
  def audit_deleted_auditor(audit,current_user)
    @audit = audit
    @user = current_user
    mail(:to => audit.auditor_email, :subject => "Notification: Audit cancelled")  
  end
  
  def audit_deleted_auditee(audit,current_user)
    @audit = audit
    @user = current_user
    mail(:to => audit.auditee_email, :subject => "Notification: Audit cancelled")  
  end
  
  def weekly_mail(user)
    @findings = []
    @capa_pending_findigs = []
    last_day_of_week = Time.now - 12.hours
    first_day_of_week = last_day_of_week - 7.days
    @audits = user.audits.where('start_date >= ? and start_date <= ?',first_day_of_week, last_day_of_week)
    user.audits.each do |audit|                 
		  audit.findings.each do |finding|
			  findings << finding                     
		  end
	  end		
    findings.each do |finding|
      if finding.status_id == "CAPA Pending"
        capa_pending_findigs << finding
      end
    end 
    start_of_next_week = Time.now.beginning_of_day
    end_of_next_week = start_of_next_week +  7.days
    @upcoming_audits = user.audits.where('start_date >= ? and start_date <= ?',start_of_next_week, end_of_next_week)
    
    @user = user
    mail(:to => user.email,  :subject => "Notification: sreenivas: Last week status")
  end
  def share_audit_schedule(email,current_user)
    #@audit = audit
    @user = current_user
    @audits = current_user.audits.where('start_date > ?',Time.now)
    mail(:to => email, :subject => "Audit schedule")  
  end
  
  def capa_pending_auto_follow_up(audit,current_user)
    @audit = audit
    @user = current_user
    mail(:to => @audit.auditee_email, :subject => "CAPA Pending Auto Follow Up")  
  end
end
