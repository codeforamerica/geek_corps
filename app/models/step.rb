class Step < DeployTask
  belongs_to :milestone, :foreign_key => :parent_id, :inverse_of => :steps
  belongs_to :app

  acts_as_taggable_on :tags, :skills

end
