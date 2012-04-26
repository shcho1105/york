require 'spec_helper'

describe "maps/index" do
  before(:each) do
    assign(:maps, [
      stub_model(Map),
      stub_model(Map)
    ])
  end

  it "renders a list of maps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
