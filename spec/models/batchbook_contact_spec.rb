require 'spec_helper'
ENV['batchbook_account'] = 'codeforamerica'
ENV['batchbook_key'] = 'something'

describe BatchbookContact do

  # before do
  #     BatchbookContact.delete_all
  #   end
  #   
  #   describe "sync with server" do
  #     before do
  #       stub_request(:get, "http://something:x@codeforamerica.batchbook.com/service/people.xml?limit=100&offset=1").
  #       with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  #       to_return(:status => 200, :body => fixture("batchbook_people.xml"), :headers => {})
  #     end
  # 
  #     it "should add contacts" do
  #       BatchbookContact.new.get_contacts(1)
  #     end
  #             
  #   end
end
