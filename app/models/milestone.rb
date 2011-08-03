class Milestone < DeployTask
  belongs_to :goal, :foreign_key => :parent_id, :inverse_of => :milestones
  has_many :steps, :foreign_key => :parent_id, :inverse_of => :milestone

  belongs_to :app

  accepts_nested_attributes_for :steps

  validate :goal_is_goal
  validate :steps_are_steps

  private 

  def goal_is_goal
    if goal.present? and not(goal.is_a? Goal)
      errors.add :goal, "must be a Goal"
    end
  end

  def steps_are_steps
    if not(steps.empty?) and not(steps.all {|step| step.is_a? Step})
      errors.add :steps, "must all be Steps"
    end
  end
end
