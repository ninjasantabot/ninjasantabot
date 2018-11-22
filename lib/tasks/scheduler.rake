desc "This task is called by the Heroku scheduler add-on"
task :send_scheduled_comms => :environment do
  SendScheduledComms.new.call
end
