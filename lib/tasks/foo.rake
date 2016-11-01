namespace :foo  do
  desc "Rake task foo:bar"
  task :bar => :environment do
    print "Bar [Rake Task]"
  end
end
