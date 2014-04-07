# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
  every :monday, :at => "11:59am" do
     runner "User.weekly_update"
    runner "Audit.capa_pending_auto_follow_up"            
  end
  every :monday, :at => "10:35pm" do
    runner "Audit.capa_pending_auto_follow_up"            
  end
