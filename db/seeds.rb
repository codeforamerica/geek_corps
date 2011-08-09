require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'uuid'

#Add Regions
puts "Adding Regions"
[["San Francisco", "CA", "SF"], ["Seattle", "WA", "SEA"], ["Boston", "MA", "BOS"], ["Philadelphia", "PA", "PHL"]]. each do |city|
  r = Region.create!(:city => city[0], :state => city[1], :nick_name => city[2], :photo => File.open(Rails.root.to_s + "/public/images/#{city[2].downcase}-icon.png"))
  puts "Created #{r.city}, #{r.state}" if r
end

#Add 20 Users to each region
Region.all.each do |region|
  puts "Creating 20 users for #{region.city}, #{region.state}"
  20.times do |i|
    user = Factory(:user, :region_id => region.id)
    Factory(:person, :user => user)
    Factory(:authentication, :user => user, :provider => 'facebook')
  end
end

def create_guide_goal(app, goal_id)
  (rand(4)+1).times do |i|
  m = Milestone.create(:app => app, :goal => goal_id, :position => i+1, :name => Faker::Lorem.sentence, :description => Faker::Lorem.paragraph)
  m.deploy_task_resources.create(:content => Faker::Lorem.sentence, :resource_type => "link", :link => Faker::Internet.domain_name)
    (rand(4)+1).times do |x|
      s = m.steps.create(:est_time => rand(60), :app => app, :goal => goal_id, :position => x+1, :name => Faker::Lorem.sentence, :description => Faker::Lorem.paragraph)
      s.deploy_task_resources.create(:content => Faker::Lorem.sentence, :resource_type => "link", :link => Faker::Internet.domain_name)
    end
  end
end

#Add Applications, Core Team and Team Members
regions = Region.all
[Factory(:app, :name => "Art Application"),
Factory(:app, :name => "City Groups"),
Factory(:app, :name => "City How"),
Factory(:app, :name => "Change By Us"),
Factory(:app, :name => "Class Talk")].each do |app|
  puts "Creating app for #{app.name}"
  5.times do |i|
    create_guide_goal(app, i+1)
  end
  core_team = app.teams.create!(:team_type => "core", :app => app)
  puts "  added core team"
  core_team.team_members.create!(:team_role => "organizer", :admin => true, :user => User.all[rand(User.all.size)], :app => app)
  puts "  added #{core_team.team_members.first.user.person.name} to core team"
  regions.each do |region|
    puts "Creating regional teams for #{app.name}"
    app_team = app.teams.create!(:team_type => "application", :app => app, :region => region)
    User.where(:region_id => region.id).each do |member|
      app_team.team_members.create!(:team_role => "supporter", :user => member, :app => app)
    end
    puts "  supporters added"
    app_team.team_members.create!(:team_role => "organizer", :user => User.where(:region_id => region.id).first, :app => app)
    puts "  organizer added"
  end
end
puts "Adding comments on all teams"  
Team.all.each do |team|
  team.team_members.each do |member|
    team.comments.create!(:user => member.user, :text => Faker::Lorem.sentence, :team => team)
  end
puts "Adding comments on all tasks for #{team.name}"    
  team.app.deploy_tasks.each do |task|
    2.times do |h| 
      task.comments.create!(:user => team.members.shuffle.last, :text => Faker::Lorem.sentence, :team => team)
    end
  end
end


