require 'spec_helper'

describe "teams/new.html.erb" do
  before(:each) do
    assign(:team, stub_model(Team,
      :app_id => 1,
      :region_id => 1,
      :team_type => "MyString",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teams_path, :method => "post" do
      assert_select "input#team_app_id", :name => "team[app_id]"
      assert_select "input#team_region_id", :name => "team[region_id]"
      assert_select "input#team_team_type", :name => "team[team_type]"
      assert_select "input#team_name", :name => "team[name]"
    end
  end
end
