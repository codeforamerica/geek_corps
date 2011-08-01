class StepResource < ActiveRecord::Base
  belongs_to :step
  has_many :comments, :as => :commentable
end
