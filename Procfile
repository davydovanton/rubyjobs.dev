release: bundle exec hanami db migrate && bundle exec hanami assets precompile
web: bundle exec puma -p $PORT
worker: bundle exec sidekiq -r ./config/boot.rb -c 7
