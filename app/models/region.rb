class Region < ActiveRecord::Base
  has_many :teams
  has_many :users

  validates_uniqueness_of :city, :on => :create, :scope => :state
  validates_presence_of :nick_name

  has_attached_file :photo
  
  def pretty_name
    self.city + ", " + self.state
  end
  
end
