require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'uuid'

@sys_admin = Factory(:role, :name => 'System Administrator')
@back_dev = Factory(:role, :name => 'Backend Developer')
@design = Factory(:role, :name => 'Designer')
@organizer = Factory(:role, :name => 'Organizer')

@roles = [@sys_admin, @back_dev, @design, @organizer]

@languages = %w(ruby python php javascript bash c c++ c# objective-c java css html)

@sys_skills = %w(puppet chef load_balancing microsoft_iis)
@back_skills = %w(rails django drupal nodejs postgresql postgis couchdb redis)
@design_skills = %w(photoshop typography photography in_design oil_painting poetry)
@organize_skills = %w(talkative enthusiastic)

@languages = @languages.map do |lang|
  Factory(:language, :name => lang)
end

@sys_skills = @sys_skills.map do |skill|
  Factory(:skill, :name => skill, :skillable => nil, :role => @sys_admin)
end

@back_skills = @back_skills.map do |skill|
  Factory(:skill, :name => skill, :skillable => nil, :role => @back_dev)
end

@design_skills = @design_skills.map do |skill|
  Factory(:skill, :name => skill, :skillable => nil, :role => @design)
end

@organize_skills = @organize_skills.map do |skill|
  Factory(:skill, :name => skill, :skillable => nil, :role => @organizer)
end

@skills = [@sys_skills, @back_skills, @design_skills, @organize_skills].flatten
puts "There are #{@skills.length} skills"

#Add Regions
puts "Adding Regions"
[["San Francisco", "CA", "SF"], ["Seattle", "WA", "SEA"], ["Boston", "MA", "BOS"], ["Philadelphia", "PA", "PHL"]]. each do |city|
  r = Region.create!(:city => city[0], :state => city[1], :nick_name => city[2], :photo => File.open(Rails.root.to_s + "public/images/#{city[2].downcase}_icon.png"))
  puts "Created #{r.city}, #{r.state}" if r
end

#Add 20 Users to each region
Region.all.each do |region|
  puts "Creating 20 users for #{region.city}, #{region.state}"
  20.times do |i|
    @role = @roles.sample
    user = Factory(:user, :region_id => region.id)
    if i.even?
      Factory(:person, :user => user, :roles => [@role], :skills => @role.skills, :languages => @languages.sample(4))
    else
      Factory(:person, :user => user, :roles => @roles.sample(2), :skills => @skills.sample(3), :languages => @languages.sample(4))
    end
    Factory(:authentication, :user => user, :provider => 'facebook')
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

