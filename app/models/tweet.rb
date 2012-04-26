class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  validates_presence_of :screen_name, :location

  # location field format [latitude, longitude]
  # db.createCollection("tweets", {capped:true, size:100000, max:200000})
  # rake db:create_indexes or db.tweets.ensureIndex({location: "2d"})
  # db.tweets.find({location: {$near: [37.7863, -122.44]}}).limit(50)

  store_in "tweets", capped: true, size: 100000, max: 100000
  field :screen_name, type: String
  field :text, type: String
  field :location, type: Array  # [latitude, longitude]
  index [[:location, Mongo::GEO2D ]], min: -180, max: 180

  def as_json(options = {})
    { :screen_name => self.screen_name, 
      :text => self.text,
      :created_at => self.created_at.strftime("%m/%d %H:%M:%S"),
      :latitude => self.location[0], 
      :longitude => self.location[1] }
  end

  # create a tweet from line output of Twitter Stream API
  def self.create_from_stream(json)
    return if json['geo'].nil? || json['geo']['coordinates'].nil?
    tweet = Tweet.new(
      :created_at => Time.parse(json['created_at']),
      :screen_name => json['user']['screen_name'],
      :text => json['text'],
      :location => [json['geo']['coordinates'][0], json['geo']['coordinates'][1]]
    )
    if tweet.save
      Rails.logger.info "TWEET [#{tweet.location[0]},#{tweet.location[1]}] #{tweet.screen_name} - #{tweet.text}"
    else
      Rails.logger.error "Unable to save tweet: #{tweet.inspect}"
    end
  end
end

