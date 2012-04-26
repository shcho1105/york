require 'em-http'
require 'json'

require File.expand_path('../config/environment.rb', File.dirname(__FILE__))

username = 'shcho1105'
password = '112358'
locations = '-123.0,36.0,-121.0,38.0' # SF Bay Area

EventMachine.run do
  http = EventMachine::HttpRequest.new(
    "https://stream.twitter.com/1/statuses/filter.json",
    :connection_timeout => 0,
    :inactivity_timeout => 0
  ).post(
    :head => {"Authorization" => [username, password]}, 
    :body => {"locations" => locations}
  )

  buffer = ""
  http.stream do |chunk|
    buffer << chunk
    while line = buffer.slice!(/.+\r?\n/)
      next if line.length < 5
      json = JSON.parse(line)
      Tweet.create_from_stream(json)
    end
  end
  http.errback {
    Rails.logger.error "HTTP ERROR: #{http.error}"
  }
end  
