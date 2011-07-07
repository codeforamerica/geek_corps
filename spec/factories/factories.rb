Factory.define :contact_source do |f|
  f.name "something"
end

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

Factory.define :region do |f|
  f.city {Faker::Address.city}
  f.state {Faker::Address.state}
  f.nick_name { "something#{rand(1000)}" }
end

Factory.define :app do |f|
  f.name { "something#{rand(1000)}" }
  f.description {Faker::Lorem.paragraph}
end

Factory.define :team do |f|
  f.app {Factory(:app)}
  f.region {Factory(:region)}
end

Factory.define :detail do |f|
end

#--[ Authentication ]-----------------------------------------------------------
Factory.define :authentication do |a|
  a.provider 'open_id'
  a.uid { UUID.generate(:compact) }
  a.info :name => 'Test Auth'
end

#--[ Person ]-------------------------------------------------------------------
Factory.define :person do |p|
  p.name { Faker::Name.name }
  p.email { Faker::Internet.email }
  p.url { Faker::Internet.domain_name }
  p.bio { Faker::Lorem.paragraph }
  p.location { Faker::Address.city }
end

#--[ User ]---------------------------------------------------------------------
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.admin false
  u.region Factory(:region)
  u.after_build do |user|
    user.authentications = [ Factory.build(:authentication, :user => user) ]
  end
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



