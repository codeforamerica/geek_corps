require 'spec_helper'

describe "details/show.html.erb" do
  before(:each) do
    @detail = assign(:detail, stub_model(Detail,
      :app_id => 1,
      :team_id => 1,
      :name => "Name",
      :setting => "Setting"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Setting/)
  end
end
