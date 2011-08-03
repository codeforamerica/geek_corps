class App < ActiveRecord::Base
  has_many :teams
  has_many :regional_teams, :class_name => "Team", :conditions => {:team_type => 'application'}
  has_one  :core_team, :class_name => "Team", :conditions => {:team_type => 'core'}
  has_many :core_team_members, :through => :core_team, :source => :team_members
  has_many :team_members
  has_many :users, :through => :team_members, :uniq => true

  has_many :details
  has_many :roles, :as => :rolable
  has_many :skills, :as => :skillable
  has_many :languages, :as => :polyglot

  has_many :deploy_tasks
  has_many :goals
  has_many :milestones
  has_many :steps

  has_many :deploy_task_resources, :through => :deploy_tasks

  accepts_nested_attributes_for :details, :deploy_tasks, :goals, :milestones, :steps

  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

  PHOTO_DEFAULTS = ["#{Rails.root.to_s}/public/images/default_app_1.png",
                    "#{Rails.root.to_s}/public/images/default_app_2.png",
                    "#{Rails.root.to_s}/public/images/default_app_3.png"]

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

  def admin?(user)
    core_team.admins.include? user
  end
  private

  def random_default
    File.new(PHOTO_DEFAULTS.sample)
  end

end
