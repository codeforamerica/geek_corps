#--[ ContactSource ]-------------------------------------------------------------------
Factory.define :contact_source do |f|
  f.name "something"
end

#--[ GithubContact ]-------------------------------------------------------------------
Factory.define :github_contact do |f|
  f.name "Code for America"
  f.created_at Time.now
  f.location "San Francisco"
  f.public_repo_count 19
  f.public_gist_count 10
  f.following_count 25
  f.followers_count 35
  f.first_commit Time.now
  f.sequence(:login) { |n| "something#{n}" }
  f.sequence(:email) { |n| "test#{n}@example.com" }
  f.contact_source {Factory(:contact_source, :name => "github")}
end

#--[ App ]-------------------------------------------------------------------
Factory.define :app do |f|
  f.sequence(:name) {|n| "#{n}something#{rand(1000000)}" }
  f.description { Faker::Lorem.paragraph }
end

#--[ Region ]-------------------------------------------------------------------
Factory.define :region do |f|
  f.city { Faker::Address.city }
  f.state { Faker::Address.state }
  f.nick_name { "something#{rand(1000000)}" }
end

#--[ Authentication ]-----------------------------------------------------------
Factory.define :authentication do |a|
  a.provider 'open_id'
  a.uid { UUID.generate(:compact) }
  a.info :name => 'Test Auth'
end

#--[ User ]---------------------------------------------------------------------
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.admin false
  u.region { Factory(:region)}
  u.after_build do |user|
    user.authentications = [ Factory.build(:authentication, :user => user) ]
  end
end

#--[ Team ]-------------------------------------------------------------------
Factory.define :team do |f|
  f.app {Factory(:app)}
  f.region {Factory(:region)}
  f.team_type "core"
  f.name Faker::Name.name
  f.repo_url "http://github.com/codeforamerica"
end

#--[ TeamMember ]-------------------------------------------------------------------
Factory.define :team_member do |f|
  f.team { Factory(:team)}
  f.user { Factory(:user)}
  f.app { Factory(:app)}
  f.team_role "supporter"
  f.admin false
end

#--[ Detail ]-------------------------------------------------------------------
Factory.define :detail do |f|
  f.app { Factory(:app)}
  f.team { Factory(:team)}
  f.setting "Some setting"
  f.name { "name#{rand(1000)}" }
end

#--[ Role ]--------------------------------------------------------------------
Factory.define :role do |r|
  r.name 'Backend Developer'
end

#--[ Language ]--------------------------------------------------------------------
Factory.define :language do |l|
  l.name 'Ruby'
end

#--[ Skill ]--------------------------------------------------------------------
Factory.define :skill do |s|
  s.name 'Rails'
  s.role { Factory(:role) }
  s.skillable Person.first
end

#--[ Person ]-------------------------------------------------------------------
Factory.define :person do |p|
  p.name { Faker::Name.name }
  p.url { Faker::Internet.domain_name }
  p.bio { Faker::Lorem.paragraph }
  p.location { Faker::Address.city }
  p.roles { [ Factory(:role) ] }
  p.languages { [ Factory(:language) ] }
  p.skills { [ Factory(:skill) ] }
end

Factory.define :admin_user, :parent => :user do |u|
  u.admin true
end

Factory.define :user_with_new_person, :parent => :user do |u|
  u.association :person
end

Factory.define :user_with_person, :parent => :user do |u|
  u.person {|u| u.association(:person, :reviewed => true) }
end


#--[ Activities and Comments ]-------------------------------------------------------------------


Factory.define :comment do |p|
  p.team {Factory(:team)}
  p.user {Factory(:user)}
  p.text 'Some nifty comment'
  p.commentable {Factory(:team)}
  p.flag false
end

Factory.define :activity_feed do |p|
  p.team {Factory(:team)}
  p.activity "Something funny"
  p.feedable {Factory(:comment)}
end

#--[ Guide ]-------------------------------------------------------------------

Factory.define :step do |s|
  s.name Faker::Lorem.sentence
  s.description Faker::Lorem.paragraph
  s.position (rand(5)+1)
end

Factory.define :milestone do |m|
  m.steps { [Factory(:step), Factory(:step), Factory(:step)] }
  m.goal (rand(5)+1)
  m.position (rand(5)+1)
  m.name Faker::Lorem.sentence
  m.description Faker::Lorem.paragraph
  m.app { Factory(:app) }
end

