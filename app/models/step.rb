class Step < DeployTask
  belongs_to :milestone, :foreign_key => :parent_id, :inverse_of => :steps
  belongs_to :goal

  validate :milestone_is_milestone
  validate :goal_is_goal
  private

  def milestone_is_milestone
    if milestone.present? && not(milestone.is_a? Milestone)
      errors.add(:milestone, "must be a Milestone")
    end
  end

  def goal_is_goal
    if goal.present? && not(goal.is_a? Goal)
      errors.add(:goal, "must be a Goal")
    end
  end
end
