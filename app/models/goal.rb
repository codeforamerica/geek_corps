class Goal < DeployTask
  has_many :milestones, :foreign_key => :parent_id, :inverse_of => :goal
  belongs_to :app

  accepts_nested_attributes_for :milestones

  validate :milestones_are_milestones

  private 

  def milestones_are_milestones
    if not(milestones.empty?) and not(milestones.all {|milestone| milestone.is_a? Milestone})
      errors.add :milestones, "must all be Milestones"
    end
  end
end
