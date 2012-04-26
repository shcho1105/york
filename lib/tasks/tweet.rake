namespace :tweet do
  namespace :stream do
    desc "Start tweet stream client"
    task :start => :environment do
      ruby "lib/tweet_stream_control.rb start"
    end

    desc "Stop tweet stream client"
    task :stop do
      ruby "lib/tweet_stream_control.rb stop"
    end
  end
end
