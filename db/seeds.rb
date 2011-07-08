require 'factory_girl'
require 'faker'
require 'factory_girl_rails'

#Add Regions
[["San Francisco", "CA", "SF"], ["Seattle", "WA", "SEA"], ["Boston", "MA", "BOS"], ["Philadelphia", "PA", "PHL"]]. each do |city|
  Region.create(:city => city[0], :state => city[1], :nick_name => city[2])
end  

#Add 20 Users to each region
Region.all.each do |region|
20.times { 
  user = Factory(:user, :region_id => region.id)
  Factory(:person, :user => user)
  Factory(:authentication, :user => user, :provider => 'facebook')
}
end

#Add Applications, Core Team and Team Members
regions = Region.all
[Factory(:app, :name => "Art Application"),
Factory(:app, :name => "City Groups"),
Factory(:app, :name => "City How"),
Factory(:app, :name => "Change By Us"),
Factory(:app, :name => "Class Talk")].each do |app|
  core_team = app.teams.create!(:team_type => "core", :app => app)
  core_team.team_members.create!(:team_role => "organizer", :admin => true, :user => User.all[rand(User.all.size)], :app => app)
  regions.each do |region|
    app_team = app.teams.create(:team_type => "application", :app => app, :region => region)
    User.where(:region_id => region.id).each do |member|
      app_team.team_members.create!(:team_role => "supporter", :user => member, :app => app)
    end
    app_team.team_members.create!(:team_role => "organizer", :user => User.where(:region_id => region.id).first, :app => app)
  end  
end






