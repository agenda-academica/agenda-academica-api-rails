uri = URI.parse(ENV["REDIS_URL"])
redis_connection = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

if Rails.env.production?
  Resque.redis = redis_connection
else
  require 'redis-namespace'
  Resque.redis = Redis::Namespace.new(ENV['REDIS_NAMESPACE'], :redis => redis_connection)
end
