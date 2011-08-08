class Milestone < DeployTask
  has_many :steps, :foreign_key => :parent_id, :inverse_of => :milestone

  belongs_to :app

  private 
  
  def steps_are_steps
    if not(steps.empty?) and not(steps.all {|step| step.is_a? Step})
      errors.add :steps, "must all be Steps"
    end
  end
end
