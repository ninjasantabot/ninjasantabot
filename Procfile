web: bin/rails server -p $PORT -e $RAILS_ENV
sidekiq_worker: bundle exec sidekiq -c 2 -q default -q mailers
