class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :admin

  has_one :person
  has_many :team_members
  has_many :teams, :through => :team_members, :source => :team
  belongs_to :region
  has_many :comments

  scope :admins, joins(:team_members).where(:team_members => {:admin => true})

  has_many :authentications, :dependent => :destroy do
    def info_get(key)
      info_with_key = self.map(&:info).compact.detect{|info| info[key].present? }
      return info_with_key[key] if info_with_key.present?
    end
  end

  devise :rememberable, :trackable

  def avatar_url
    if self.person.present?
      self.person.photo.url(:thumb)
    elsif self.authentications.present?
      (self.authentications.info_get(:image) || '/images/geekcorpsavatar1.png')
    else
      '/images/geekcorpsavatar1.png'
    end
  end

  def name
    self.person.try(:name) || self.authentications.info_get(:name) || "User #{self.id}"
  end

  def label_for_admin
    "#{self.id}: #{self.name} #{self.person.present? ? '*' : ''}"
  end

  def default_authentication
    self.authentications.first
  end

  def has_auth_from?(provider)
    self.authentications.via(provider).present?
  end

end

