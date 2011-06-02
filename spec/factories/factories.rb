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