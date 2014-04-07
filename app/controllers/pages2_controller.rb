class Pages2Controller < ApplicationController
  skip_filter :authenticate_user!
  include HighVoltage::StaticPage

 def landing
   render :layout => 'landing2'
  end 
  
  private

  def layout_for_page
    case params[:id]
    when 'landing2'
      'landing2'
    else
      'application'
    end
  end

  
  
end
