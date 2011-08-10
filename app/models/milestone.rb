class Milestone < DeployTask
  has_many :steps, :foreign_key => :parent_id, :inverse_of => :milestone
  belongs_to :app

  def skill_list
    skills = steps.inject([]) do |a,b|
      a += b.skill_list
      a.uniq
    end
  end
end
