class ContactSource < ActiveRecord::Base
  has_many :github_contacts
  validates_presence_of :name, :on => :create, :message => "can't be blank"
end
