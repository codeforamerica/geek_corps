class Role < ActiveRecord::Base
  belongs_to :rolable, :polymorphic => true
  has_many :skills
end
