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
  u.after_build do |user|
    user.authentications = [ Factory.build(:authentication, :user => user) ]
  end
end

#--[ Team ]-------------------------------------------------------------------
Factory.define :team do |f|
  f.team_type "core"
  f.name Faker::Name.name
  f.region "(37.75459549838729, -122.60032236194616)(37.78933228160323, -122.2899585924149)(37.59590195263007, -122.2624927721024)(37.576313499982945, -122.56736337757116)"
end

#--[ TeamMember ]-------------------------------------------------------------------
Factory.define :team_member do |f|
  f.team { Factory(:team)}
  f.user { Factory(:user)}
  f.team_role "supporter"
end

#--[ Person ]-------------------------------------------------------------------
Factory.define :person do |p|
  p.name { Faker::Name.name }
  p.url { Faker::Internet.domain_name }
  p.bio { Faker::Lorem.paragraph }
  p.location { Faker::Address.city }
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



