desc "This task is called by the Heroku scheduler add-on"
task :run_daily_tasks => :environment do
  RunDailyTasks.new.call
end
