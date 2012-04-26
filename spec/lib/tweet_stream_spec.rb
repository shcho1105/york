require 'spec_helper'

describe TweetStream do
  it "should be initialized" do
    ts = TweetStream.new
    ts.should be
    ts.host.should == 'https://stream.twitter.com/1/statuses/sample.json'
    ts.username.should == 'shcho1105'
    ts.password.should be
  end

  it "should start EventMachine" do
  end
end
