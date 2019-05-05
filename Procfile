release: bundle exec hanami db migrate && bundle exec hanami assets precompile
web: bundle exec hanami server -p $PORT --no-code-reloading
worker: bundle exec sidekiq -r ./config/boot.rb -c 7
