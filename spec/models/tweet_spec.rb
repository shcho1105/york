require 'spec_helper'

describe Tweet, ".create_from_stream" do
  before(:each) do
    @sample = eval(IO.read(File.expand_path("spec/fixtures/files/tweet_sample.txt", Rails.root)))
  end

  it "should create Tweet from stream output" do
    lambda {
      Tweet.create_from_stream(@sample)
    }.should change(Tweet, :count).by(1)
    tweet = Tweet.last
    tweet.created_at.should == Time.parse(@sample['created_at'])
    tweet.screen_name.should == @sample['user']['screen_name']
    tweet.text.should == @sample['text']
    tweet.location.should == [@sample['geo']['coordinates'][0], @sample['geo']['coordinates'][1]]
  end
end
