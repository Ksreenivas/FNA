class Report < ActiveRecord::Base
  attr_accessible :report_name, :report_status, :report_tag
end
