class Step < DeployTask
  belongs_to :milestone, :foreign_key => :parent_id, :inverse_of => :steps

  belongs_to :app

  validate :milestone_is_milestone
  private

  def milestone_is_milestone
    if milestone.present? && not(milestone.is_a? Milestone)
      errors.add(:milestone, "must be a Milestone")
    end
  end
end
