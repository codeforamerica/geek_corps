class Region < ActiveRecord::Base
  has_many :teams
  has_many :users

  validates_uniqueness_of :city, :on => :create, :scope => :state
  validates_presence_of :nick_name

  has_attached_file :photo, :storage => :s3,
    :bucket => 'geekcorps_' + Rails.env,
    :path => '/:id/:filename',
    :s3_credentials => {
      :access_key_id => S3_KEY,
      :secret_access_key => S3_SECRET
    }
end
