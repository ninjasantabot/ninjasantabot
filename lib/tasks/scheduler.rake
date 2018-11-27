desc "This task is called by the Heroku scheduler add-on"
task :run_midday_tasks => :environment do
  RunMiddayTasks.new.call
end

task :run_morning_tasks => :environment do
  RunMorningTasks.new.call
end
