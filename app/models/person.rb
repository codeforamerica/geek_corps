class Person < ActiveRecord::Base
  require 'open-uri'
  require 'digest/md5'

  attr_accessor :photo_import_url
  attr_protected :user_id

  PHOTO_DEFAULTS = ["#{Rails.root.to_s}/public/images/default_person_1.png",
                    "#{Rails.root.to_s}/public/images/default_person_2.png",
                    "#{Rails.root.to_s}/public/images/default_person_3.png"]

  PHOTO_SIZES = {:medium => 220, :thumb => 48} # for gravatar

  acts_as_taggable_on :tags, :technologies

  # s3 credentials specified in _load_settings
  has_attached_file :photo, :storage => :s3,
  :bucket => 'geekcorps_' + Rails.env,
  :path => "/:id/:filename",
  :s3_credentials => {
    :access_key_id => S3_KEY,
    :secret_access_key => S3_SECRET
  }

  belongs_to :user
  has_many :skills, :as => :skillable
  has_many :roles, :as => :rolable
  has_many :languages, :as => :polyglot

  before_validation :on => :create do
    if self.photo_import_url.present?
      io = open(URI.parse(self.photo_import_url))
      def io.original_filename; base_uri.path.split('/').last; end

      self.photo = io if io.original_filename.present?
    elsif self.photo_import_url.nil? && self.photo.nil?
      self.photo = random_default
    end
  end

  validates_presence_of :name

  before_save :attach_to_matching_user

  scope :claimed, where('user_id IS NOT null')
  scope :unclaimed, where('user_id IS null')

  private

  def random_default
    File.new(PHOTO_DEFAULTS.sample)
  end

  def matching_user
    @matching_user ||= Authentication.where( :provider => self.imported_from_provider,
                                             :uid => self.imported_from_id ).first.try(:user)
  end

  def attach_to_matching_user
    if self.user.nil? && matching_user.present?
      self.user = matching_user
    end
  end
end

