class Person < ActiveRecord::Base
    require 'open-uri'
    require 'digest/md5'


    attr_protected :user_id
    has_paper_trail :ignore => [:user_id, :delta]
    acts_as_taggable_on :tags, :technologies
    sortable

    default_serialization_options :include => { :tags => {}, :technologies => {}}

    # s3 credentials specified in _load_settings
    has_attached_file :photo, :styles => { :medium => '220x220#', :thumb => '48x48#' }, :storage => :s3,
    :bucket => 'geekcorps_'+ENV["RAILS_ENV"].to_s,
    :s3_credentials => {
      :access_key_id => S3_KEY,
      :secret_access_key => S3_SECRET
    }
    
    PHOTO_SIZES = {:medium => 220, :thumb => 48} # for gravatar

    attr_accessor :photo_import_url
    before_validation do
      if self.photo_import_url.present?
        io = open(URI.parse(self.photo_import_url))
        def io.original_filename; base_uri.path.split('/').last; end

        self.photo = io if io.original_filename.present?
      end
    end

    belongs_to :user

    validates_presence_of :name

    before_save :attach_to_matching_user

    scope :claimed, where('user_id IS NOT null')
    scope :unclaimed, where('user_id IS null')

    # returns a photo url, with fallback to a unique-within-epdx generated avatar from gravatar
    def photo_url(size)
      size ||= :medium
      self.photo.file? ? self.photo.url(size) : "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.id.to_s)}?d=retro&f=y&s=#{PHOTO_SIZES[size]}"
    end

    private

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


