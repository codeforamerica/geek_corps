require 'spec_helper'

describe "regions/show.html.erb" do
  before(:each) do
    @region = assign(:region, stub_model(Region,
      :city => "City",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
