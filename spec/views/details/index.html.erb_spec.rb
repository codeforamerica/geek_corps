require 'spec_helper'

describe "details/index.html.erb" do
  before(:each) do
    assign(:details, [
      stub_model(Detail,
        :app_id => 1,
        :team_id => 1,
        :name => "Name",
        :setting => "Setting"
      ),
      stub_model(Detail,
        :app_id => 1,
        :team_id => 1,
        :name => "Name",
        :setting => "Setting"
      )
    ])
  end

  it "renders a list of details" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Setting".to_s, :count => 2
  end
end
