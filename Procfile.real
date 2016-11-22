web: bundle exec puma -C config/puma.rb
resque: env QUEUE=* bundle exec rake environment resque:work
resque-scheduler: env bundle exec rake environment resque:scheduler
