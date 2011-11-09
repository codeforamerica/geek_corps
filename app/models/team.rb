class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, :through => :team_members, :source => :user
  has_many :admins, :through => :team_members, :source => :user, :conditions => {:team_members => {:admin => true}}
  has_many :activity_feeds
  has_many :comments, :as => :commentable
  before_save :alter_name
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

  def to_url
    "/" + hypen_name
  end

  def pretty_name
    self.name.gsub('-', " ").downcase.titleize
  end

  def admin?(user)
    admins.include? user
  end
  
  def alter_name
    self.name = name.downcase
  end
  
  def hypen_name
    self.name.gsub(" ", "-")
  end

end
