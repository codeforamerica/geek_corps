require 'spec_helper'

describe GithubContact do

  before do
    GithubContact.delete_all
  end
  
  describe "sync with server" do
    before do
      stub_request(:get, "http://stats.codeforamerica.org/coders.json").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => fixture("github_contacts.json"), :headers => {})
    end

    it "should add all coders" do
      Factory(:contact_source, :name => "github")
      GithubContact.count.should == 0
      GithubContact.new.get_contacts
      GithubContact.count.should == 2
    end
            
  end
  
  describe "update coders with server" do
    before do
      stub_request(:get, "http://stats.codeforamerica.org/coders.json").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => fixture("github_contacts_update.json"), :headers => {})
    end

    it "should add all coders" do
      Factory(:github_contact, :login => "Buttonpresser")
      GithubContact.count.should == 1
      GithubContact.new.update_new_contacts
      GithubContact.count.should == 2
    end
            
  end
  
  describe "update coder" do
    before do
      stub_request(:get, "http://stats.codeforamerica.org/coders.json?login=danmelton").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => fixture("github_contacts_update_coder.json"), :headers => {})
    end

    it "should add all coders" do
      coder = Factory(:github_contact, :login => "danmelton")
      GithubContact.count.should == 1
      coder.following_count.should == 25
      coder.update_contact
      coder.reload.following_count.should == 19
    end
            
  end
  
  pending "sync with server and update coders"
  pending "sync with server and add new coders"

  after do
    GithubContact.delete_all
  end
end
