require 'spec_helper'

describe "tweets/show" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
