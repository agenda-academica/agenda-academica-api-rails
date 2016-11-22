Resque.logger.formatter = Resque::VeryVerboseFormatter.new
Resque.redis = ENV['REDIS_URL']
