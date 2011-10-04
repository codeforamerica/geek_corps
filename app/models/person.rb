class Person < ActiveRecord::Base
  require 'open-uri'
  require 'digest/md5'
  after_create :add_location_to_user

  attr_accessor :photo_import_url
  attr_protected :user_id

  PHOTO_DEFAULTS = ["/images/geekcorpsavatar1.png",
                    "/images/geekcorpsavatar2.png",
                    "/images/geekcorpsavatar3.png"]

  PHOTO_SIZES = {:medium => 220, :thumb => 48} # for gravatar

  acts_as_taggable_on :tags, :skills

  # s3 credentials specified in _load_settings
  has_attached_file :photo, :storage => :s3,
  :bucket => 'geekcorps_' + Rails.env,
  :path => "/:id/:filename",
  :default_url => PHOTO_DEFAULTS[rand(2)],
  :s3_credentials => {
    :access_key_id => S3_KEY,
    :secret_access_key => S3_SECRET
  }

  belongs_to :user

  before_validation :on => :create do
    if self.photo_import_url.present?
      io = open(URI.parse(self.photo_import_url))
      def io.original_filename; base_uri.path.split('/').last; end

      self.photo = io if io.original_filename.present?
    elsif self.photo_import_url.nil? && self.photo.nil?
      self.photo = random_default
    end
  end

  validates_presence_of :name, :location

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
  
  def add_location_to_user
    if self.user
      self.user.update_attributes(:region_id => self.location.to_i)
    end
  end

  def get_image
    begin
    twitter_url = "http://www.twitter.com/#{self.twitter}"
    doc = Nokogiri::HTML(open(twitter_url,"User-Agent" => "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.872.0 Safari/535.2"))
    image_url = doc.at_css("img#profile-image").attributes["src"].value 
    new_image_url = image_url.gsub("_bigger", "")
    image = open(new_image_url)
    self.update_attributes(:photo => image)
    rescue
      puts tweeter
    end
  end
  
end

