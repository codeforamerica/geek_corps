require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'uuid'
require 'open-uri'

if Rails.env!='production'

skills = ['ruby', 'python', 'javascript', 'celery', 'juggling', 'node.js', 'design', 'art', 'user experience', 'fundraising', 'marketing', 'php', 'wordpress', 'drupal','couchdb', '.net', 'mongodb', 'mysql'] 

#Add 50 Users
  puts "Creating 50 users"
  50.times do |i|
    user = Factory(:user)
    Factory(:person, :user => user)
    Factory(:authentication, :user => user, :provider => 'facebook')
    person = user.reload.person
    (rand(6)+1).times { |x| person.skill_list << skills.shuffle.last }
    person.save
  end

  puts "Creating 10 Teams"  
  10.times {
    team = Factory(:team)
    team.members << User.all.shuffle[0..10]
    team.team_members.shuffle[0..2].each do |team_member| 
      team_member.admin = true
      team_member.save
    end
  }


end
