class DashboardsController < ApplicationController
  # GET /dashboards
  # GET /dashboards.json
  def index
    @audits = current_user.audits.where("auditor_email = ? or secondry_auditor_email = ? ", current_user.email,current_user.email)
    
    @finding_count =0
    @open_audits_count = 0
    @open_audits = []
    @in_progress_audits =[]
    @upcoming_audits = []
    @capa_pending_audits = []
    @findings_capa_pending = []
    @findings_under_review = []
    @findings_closed = []
    
    @open_audits_month_wise = []
    @in_progress_audits_month_wise = []
    @closed_audits_month_wise = []
    audit_closed =false
    
    @audits.each do |audit|
      audit.findings.each do|finding|
        @finding_count += 1  
        if finding.status_id == "CAPA Pending" || finding.status_id == "" ||  finding.status_id == nil
            @findings_capa_pending << finding
        elsif finding.status_id == "Under review"
            @findings_under_review <<  finding
        elsif  finding.status_id == "Closed"
          @findings_closed << finding
        end 
      end
    end
    
    @audits.each do |audit|
      
    end
    
    @audits.each do |audit|
      audit.findings.each do|finding|
        if finding.status_id != "Closed" && (Time.now.to_date - finding.created_at.to_date).to_i >=30
          @open_audits_count += 1
          @open_audits << audit
          break  
        end 
      end
      if (audit.start_date.to_i..audit.end_date.to_i).include?(Time.now.to_i)
        @in_progress_audits << audit
      end  
    end
    @audits.each do |audit|
      audit.findings.each do|finding|
        if finding.status_id == "CAPA Pending" 
          #@open_audits_count += 1
          puts "****************************"
     #     puts @capa_pending_audits.inspect
          puts "****************************"
          @capa_pending_audits << audit
          break  
        end 
      end
    end
   puts "********capa_pending_audits*********#{@capa_pending_audits.inspect}"
    @upcoming_audits = current_user.audits.where('start_date >= ?',Time.now)
   # @in_progress_audits = (audit.start_date.to_i..audit.end_date.to_i).include?(Time.now.to_i) 
    @findings = Finding.find(:all)
   # months = ['Jan','Feb', 'Mar','Apr','May','Jun','Jul','Aug','Sep','Oct', 'Nov','Dec']
   # col_chart = [[]]
   # months.each_with_index do |month,index|
      
  #    col_chart[index] = Array.new
  #    col_chart[index] = ['1','2','3']
  #  end   
  #  puts "**************this is the col chart**********"
  #  puts col_chart
  #  puts "***********************************************"
    # testing data from index for google col chart
    #dataTable.addColumn(["one", "two", "three","four"]);
    #    <% current_user.audits.each do |audit| %>
    #          dataTable.addRow([<%= audit.id %>,<%= audit.id %> ,<%= audit.id %> ,<%= audit.id %>]) 
    #    <%end%>  
    #      alert("*************"+dataTable);
    audits = Audit.all
    #audits.each do |audit|
    #  @data_table.add_row([audit.created_at, audit.start_date, audit.start_date, audit.start_date])
    #end
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def capa_pending_audits
    puts "**************************"
    puts params[:audit_id]
    puts "***************************"  
    @capa_pending_findings = []
    @audit = Audit.find(params[:audit_id])
    @audit.findings.each do |finding|
        if finding.status_id == "CAPA Pending" || finding.status_id == ""
              @capa_pending_findings <<  finding
        end
      end
    respond_to do |format|
     # format.html # show.html.erb
     format.json { render json:  @capa_pending_findings.to_json }
    end  
    puts "*****@capa_pending_findings*************#{@capa_pending_findings.inspect}"
  end
  def capa_pending_findings
    puts "action called"
    puts params.inspect
    puts "*********************"
    @audit = Audit.find(params[:audit_id])
    
  end
 end