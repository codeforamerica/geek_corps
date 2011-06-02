class GithubContact < ActiveRecord::Base
  belongs_to :contact_source
  validates_uniqueness_of :login, :on => :create, :message => "must be unique"
  
  # grabs coders from stats.codeforamerica.org/coders.json
  #
  # @return GithubContacts array
  # @example GithubContact.new.get_contacts
  
  def get_contacts
    contacts = grab_feed
    contacts.each do |contact|
      contact["contact_source"] = ContactSource.where(:name => 'github').first
      contact.delete("org_id")
      GithubContact.create(contact)
    end
  end
  
  # grabs coders from stats.codeforamerica.org/coders.json and adds new ones
  #
  # @return GithubContacts array
  # @example GithubContact.new.update_get_contacts
  
  def update_new_contacts
    contacts = grab_feed
    old_logins = GithubContact.all.map(&:login)
    new_logins = contacts.collect {|x| x["login"]}
    add_logins = new_logins - old_logins
    if !add_logins.blank?
      add_logins.each do |contact_login|
        GithubContact.create(contacts.detect {|x| x["login"] = contact_login}.delete("org_id"))
      end
    end
  end

  # updates a coder from stats.codeforamerica.org/coders.json?login=danmelton
  #
  # @return true
  # @example GithubContact.first.update_contact
  
  def update_contact
    contact = grab_feed("http://stats.codeforamerica.org/coders.json?login=#{self.login}").first
    contact.delete("org_id")
    self.update_attributes(contact)
  end
  
  # returns a parsed json hash of coders
  #
  # @return true
  # @example GithubContact.new.grab_feed
  
  def grab_feed(url="http://stats.codeforamerica.org/coders.json")
    JSON.parse(Net::HTTP.get(URI.parse(url)))[1].collect { |x| x["coder"]}
  end
  
end
