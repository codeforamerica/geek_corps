class BatchbookContact < ActiveRecord::Base
  acts_as_taggable
  validates_uniqueness_of :location_id, :on => :create, :message => "must be unique"    
  
  # grabs batchbook contacts
  #
  # @return GithubContacts array
  # @example GithubContact.new.get_contacts
  
  def get_contacts(page=1, number=50)
    before_count = BatchbookContact.count
    contacts = batchbook_request("/people.xml?offset=#{page}&limit=#{number}")
    contacts[0][1].each do |contact|
      create_contact(contact)
    end
    
    # after_count = BatchbookContact.count
    # BatchbookContact.new.delayed.get_contacts(page+1) unless before_count == after_count
  end
  
  def batchbook_request(endpoint)
    MultiXml.parser = :rexml
    Net::HTTP.start("codeforamerica.batchbook.com", :use_ssl => true) {|http|
       req = Net::HTTP::Get.new("/service" + endpoint)
       req.basic_auth ENV['batchbook_key'], 'x'       
       response = http.request(req)
       MultiXml.parse(response.body)
     }
  end
  
  def create_contact(contact)
    # prep the hash
    contact["batchbook_id"] = contact["id"]
    tags = contact["tags"]
    locations = contact["locations"]
    %w(id tags contacts locations large_image small_image title mega_comments notes company_id company).each { |x| contact.delete(x) }    
    contact["locations"].each do |location|
      location["location_id"] = location["id"]
      %w(id).each { |x| location.delete(x) }
    end
  
end
