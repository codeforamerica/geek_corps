class App < ActiveRecord::Base
  has_many :teams
  has_many :details
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
end
