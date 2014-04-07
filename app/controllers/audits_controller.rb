
class AuditsController < ApplicationController
     before_filter :check_audit_status, :only => [:edit,:update]
      require 'prawn'
  # GET /audits
  # GET /audits.json
  def index
    @audits_not_started = current_user.audits.where('start_date > ?',Time.now)      
    @audits= current_user.audits.paginate(:page => params[:page], :per_page => 3).order('id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end

  end

  # GET /audits/1
  # GET /audits/1.json
  def show
    @audit = current_user.audits.find(params[:id])
    @findings= @audit.findings.paginate(:page => params[:page], :per_page => 7).order('id DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audit }
     
    end
  end

  # GET /audits/new
  # GET /audits/new.json
  def new
    @audit = current_user.audits.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audit }
    end
  end

  # GET /audits/1/edit
  def edit
    @audit = current_user.audits.find(params[:id])
    
  end

  # POST /audits
  # POST /audits.json
  def create
    @audit = current_user.audits.new(params[:audit])
    audit = params[:audit]
    start_date = DateTime.new(params["audit"]["start_date(1i)"].to_i, params["audit"]["start_date(2i)"].to_i,params["audit"]["start_date(3i)"].to_i,
                                                                    params["audit"]["start_date(4i)"].to_i,params["audit"]["start_date(5i)"].to_i)
    
    end_date = DateTime.new(params["audit"]["end_date(1i)"].to_i, params["audit"]["end_date(2i)"].to_i,params["audit"]["end_date(3i)"].to_i,
                                                                    params["audit"]["end_date(4i)"].to_i,params["audit"]["end_date(5i)"].to_i)
     @all_audits = Audit.where("auditor_email = ? or auditee_email = ?",params[:audit][:auditor_email], params[:audit][:auditee_email])
    
      @all_audits.each do |audit|
             if (audit.start_date.to_i..audit.end_date.to_i).include?(start_date.to_i||end_date.to_i)
               @audit.errors[:base] << "Auditor or auditee is already assigned, please select another date "
                 break
             end
         end
    
    respond_to do |format|
       if @audit.errors.any?
            format.html { render action: "new" }
            format.json { render json: @audit.errors, status: :unprocessable_entity }
       elsif @audit.save
         UserMailer.assign_audit(@audit,@audit.auditor_email,current_user).deliver
         UserMailer.assign_auditee(@audit,@audit.auditee_email,current_user).deliver
        format.html { redirect_to audits_path, notice: 'Audit was successfully created.' }
        format.json { render json: @audit, status: :created, location: @audit }
      else
        format.html { render action: "new" }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /audits/1
  # PUT /audits/1.json
  def update
    @audit = current_user.audits.find(params[:id])
  
    if @audit.auditor_email != params[:audit][:auditor_email]
       UserMailer.audit_deleted_auditor(@audit,current_user).deliver
       UserMailer.assign_audit(@audit,params[:audit][:auditor_email],current_user).deliver       
    end  
    if @audit.auditee_email != params[:audit][:auditee_email]
      UserMailer.audit_deleted_auditee(@audit,current_user).deliver     
      UserMailer.assign_auditee(@audit,params[:audit][:auditee_email],current_user).deliver
    end  
    respond_to do |format|
      if @audit.update_attributes(params[:audit])
        format.html { redirect_to audits_path, notice: 'Audit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audits/1
  # DELETE /audits/1.json
  def destroy
 
    @audit = current_user.audits.find(params[:id])
    @audit.destroy
    
    UserMailer.audit_deleted_auditor(@audit,current_user).deliver
    UserMailer.audit_deleted_auditee(@audit,current_user).deliver
    respond_to do |format|
      format.html { redirect_to audits_url }
      format.json { head :no_content }
    end
  end
  
  def export_findings
    audit = current_user.audits.find(params[:audit_id].to_i)
   
# # item = Consolidation.find_all_by_customer_id_and_status(params[:customer_id],true).map do |item|
# # [
# # item.settlement_date.strftime("%m/%d/%Y"),
# # item.settlement_amount,
# # item.ach_conf_code,
# # ]
# # end
# item.unshift(["Date","Settlement Amount","ACH Reference"])
    pdf = Prawn::Document.new 
    pdf.font_size 8 
    number=0
    point = -50
 #   pdf.bounding_box pdf.bounds.top_left, :width => 500 do
    
       pdf.bounding_box [point+50, pdf.cursor+10], :width => 500  do
         pdf.transparent(1.0) {pdf.stroke_bounds }
         #pdf.total_left_padding 10                
         pdf.move_down 5
       #pdf.pad(60) do 
         #  pdf.text.margin 0.5
        # pdf.margin_left (10) do
         pdf.text "Department Name :"+ audit.department_name if audit.department_name
         pdf.move_down 5
         pdf.text "Created On: " + audit.created_at.strftime("%d-%m-%y")
         pdf.move_down 5
         pdf.text "Audit Rating : " + "No Rating"
         pdf.move_down 5
         pdf.text "Start date: : " + audit.start_date.strftime("%d-%m-%y") if audit.start_date
         pdf.move_down 5
         pdf.text "End date:  : " + audit.end_date.strftime("%d-%m-%y") if audit.end_date
         pdf.move_down 5
         pdf.text "Auditor : " + audit.auditor_name
         pdf.move_down 5
         pdf.text "Auditee : " + audit.auditee_name
         pdf.move_down 5
         pdf.text "Location : " + audit.location.to_s
         pdf.move_down 5
         pdf.text "Status : " + ""
        
        pdf.transparent(1.0) {pdf.stroke_bounds }
        pdf.move_down 30
       #end
      end

    audit.findings.each do |finding|
       pdf.text "Finding #{number += 1}"  
       pdf.move_down 10
       pdf.bounding_box [point+50, pdf.cursor+1], :width => 500,:padding => 50  do
        pdf.stroke_bounds 
        pdf.move_down 5
        pdf.text "Observation: " + finding.description if finding.description
        pdf.move_down 5
        pdf.text "Corrective Action : " + finding.corrective_action if finding.corrective_action
        pdf.move_down 5
        pdf.text "Preventive Action : " + finding.preventive_action if finding.preventive_action
        pdf.move_down 5
        pdf.text "Risk Rating : " + finding.risk_rating if finding.risk_rating
        pdf.move_down 5 
        pdf.text "Status : " + finding.status_id if finding.status_id
        pdf.move_down 5
         pdf.text "Closed On : " + ""
        pdf.move_down 10
        #pdf.stroke_bounds 
        pdf.stroke_bounds 
        pdf.move_down 30
    end  
    end

     
  #  end
    
      filename = File.join(Rails.root, "/public", "findings.pdf")
      pdf.render_file filename
      
      send_data pdf.render, :filename => "findings.pdf", :type => "application/pdf"
   end
  
  def share_schedule
    emails = params[:email].split(',')
    emails.each do |email|
      puts "#{email}"
      UserMailer.share_audit_schedule(email,current_user).deliver
    end
    
    redirect_to audits_path,:notice => "Audit Schedule shared."
  end
  def find_capa
    @capa = Finding.find(params[:finding_id]).corrective_action
    respond_to do |format|
     # format.html # show.html.erb
     format.json { render json:  @capa.to_json }
    end
  end
  private
      def check_audit_status
        audit = current_user.audits.find(params[:id])
        if  !(audit.start_date.to_i > Time.now.to_i)
          redirect_to "/404.html"
          
        end
      end
 end
