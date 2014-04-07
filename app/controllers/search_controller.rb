class SearchController < ApplicationController
  
  def index
    
    terms=[]
    terms = params[:search].split(' ')
    terms << params[:search].strip
    audit_conditions = []
    finding_conditions = []
    values = {}

   terms.each_with_index do |t,i|
     arg_id = "term#{i}".to_sym
     
     audit_conditions << "department_name LIKE :#{arg_id} OR auditee_name LIKE :#{arg_id} OR auditee_email LIKE :#{arg_id}
                                  OR auditor_name LIKE :#{arg_id} OR auditor_email LIKE :#{arg_id} OR audit_type LIKE :#{arg_id} "
     finding_conditions << "description LIKE :#{arg_id} OR category LIKE :#{arg_id} OR risk_rating LIKE :#{arg_id}
                              OR corrective_action LIKE :#{arg_id} OR preventive_action LIKE :#{arg_id} OR status_id LIKE :#{arg_id} OR iso_clause LIKE :#{arg_id}"
     values[arg_id] = "%"+t+"%"
    end
    
      @audits = current_user.audits.paginate(:page => params[:page], :per_page => 10).where(audit_conditions.join(' OR '), values)
      @findings = Finding.paginate(:page => params[:page], :per_page => 10).where(finding_conditions.join(' OR '), values)
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end
  end
end
