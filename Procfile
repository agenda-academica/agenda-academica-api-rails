web: bundle exec puma -C config/puma.rb
scheduler: env bundle exec rake environment resque:scheduler
worker: env QUEUE=* bundle exec rake environment resque:work
