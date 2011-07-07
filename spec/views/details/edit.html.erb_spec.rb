require 'spec_helper'

describe "details/edit.html.erb" do
  before(:each) do
    @detail = assign(:detail, stub_model(Detail,
      :app_id => 1,
      :team_id => 1,
      :name => "MyString",
      :setting => "MyString"
    ))
  end

  it "renders the edit detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => details_path(@detail), :method => "post" do
      assert_select "input#detail_app_id", :name => "detail[app_id]"
      assert_select "input#detail_team_id", :name => "detail[team_id]"
      assert_select "input#detail_name", :name => "detail[name]"
      assert_select "input#detail_setting", :name => "detail[setting]"
    end
  end
end
