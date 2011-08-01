class App < ActiveRecord::Base
  has_many :teams
  has_one  :core_team, :class_name => "Team", :conditions => {:team_type => 'core'}
  has_many :details
  has_many :team_members
  has_many :members, :through => :team_members, :source => :user, :uniq => true
  has_many :roles, :as => :rolable
  has_many :skills, :as => :skillable
  has_many :languages, :as => :polyglot
  has_many :steps

  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

  attr_accessor :photo_import_url

  PHOTO_DEFAULTS = ["#{Rails.root.to_s}/public/images/default_app_1.png",
                    "#{Rails.root.to_s}/public/images/default_app_2.png",
                    "#{Rails.root.to_s}/public/images/default_app_3.png"]

  PHOTO_SIZES = {:medium => 220, :thumb => 48 }

  has_attached_file :photo,
    :storage => :s3,
    :bucket => 'geekcorps_' + Rails.env,
    :path => "/app_photo/:id/:filename",
    :s3_credentials => {
      :access_key_id => S3_KEY,
      :secret_access_key => S3_SECRET
    }

  has_attached_file :video,
    :storage => :s3,
    :bucket => 'geekcorps_' + Rails.env,
    :path => "/app_video/:id/:filename",
    :s3_credentials => {
      :access_key_id => S3_KEY,
      :secret_access_key => S3_SECRET
    }

  before_validation :on => :create do
    if self.photo.nil?
      self.photo = random_default
    end
  end

  # shouldn't these be scopes?
  def core_team_members
    self.teams.where(:team_type => "core").first.team_members
  end

  def regional_teams
    self.teams.where(:team_type => "application")
  end

  def all_members
    total_members = []
    self.teams.each do |team|
      total_members << team.members
    end
    total_members.uniq!
  end

  private

  def random_default
    File.new(PHOTO_DEFAULTS.sample)
  end

end
