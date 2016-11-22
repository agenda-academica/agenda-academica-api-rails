if Rails.env.production?
  uri = URI.parse(ENV['REDIS_URL'])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  uri = URI.parse('redis://localhost:6380')
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
