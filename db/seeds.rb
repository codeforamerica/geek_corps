require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'uuid'
require 'open-uri'

if Rails.env!='production'

skills = ['ruby', 'python', 'javascript', 'celery', 'juggling', 'node.js', 'design', 'art', 'user experience', 'fundraising', 'marketing', 'php', 'wordpress', 'drupal','couchdb', '.net', 'mongodb', 'mysql'] 

#Add 50 Users
  puts "Creating 50 users for #{region.city}, #{region.state}"
  50.times do |i|
    user = Factory(:user)
    Factory(:person, :user => user)
    Factory(:authentication, :user => user, :provider => 'facebook')
    person = user.reload.person
    (rand(6)+1).times { |x| person.skill_list << skills.shuffle.last }
    person.save
  end
# 
# #Add Applications, Core Team and Team Members
# regions = Region.all
# [Factory(:app, :name => "Art Application"),
# Factory(:app, :name => "City Groups"),
# Factory(:app, :name => "City How"),
# Factory(:app, :name => "Change By Us"),
# Factory(:app, :name => "Class Talk")].each do |app|
#   puts "Creating app for #{app.name}"
#   5.times do |i|
#     create_guide_goal(app, i+1, skills)
#   end
#   core_team = app.teams.create!(:team_type => "core", :app => app)
#   puts "  added core team"
#   core_team.team_members.create!(:team_role => "organizer", :admin => true, :user => User.all[rand(User.all.size)], :app => app)
#   puts "  added #{core_team.team_members.first.user.person.name} to core team"
#   regions.each do |region|
#     puts "Creating regional teams for #{app.name}"
#     app_team = app.teams.create!(:team_type => "application", :app => app, :region => region)
#     User.where(:region_id => region.id).each do |member|
#       app_team.team_members.create!(:team_role => "supporter", :user => member, :app => app)
#     end
#     puts "  supporters added"
#     app_team.team_members.create!(:team_role => "organizer", :user => User.where(:region_id => region.id).first, :app => app)
#     puts "  organizer added"
#   end
# end
# puts "Adding comments on all teams"  
# Team.all.each do |team|
#   team.team_members.each do |member|
#     team.comments.create!(:user => member.user, :text => Faker::Lorem.sentence, :team => team)
#   end
# puts "Adding comments on all tasks for #{team.name}"    
#   team.app.deploy_tasks.each do |task|
#     2.times do |h| 
#       task.comments.create!(:user => team.members.shuffle.last, :text => Faker::Lorem.sentence, :team => team)
#     end
#      2.times do |h| 
#       task.comments.create!(:user => team.members.shuffle.last, :text => Faker::Lorem.paragraph, :team => team)
#     end
#  end
# end

end
