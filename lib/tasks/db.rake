namespace :db do
  desc "Ensure creating indexes"
  task :migrate => "create_indexes"

  namespace :test do
    desc "Ensure creating indexes"
    task :prepare => "db:create_indexes"
  end
end
