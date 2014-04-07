class PagesController < ApplicationController
  skip_filter :authenticate_user!
  include HighVoltage::StaticPage

 def landing
   render :layout => 'landing'
  
  end 
  
  private

  def layout_for_page
    case params[:id]
    when 'landing'
      'landing'
    else
      'application'
    end
  end
  

end
