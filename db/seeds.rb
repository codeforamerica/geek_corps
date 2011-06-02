# Add sources

%w([github]).each do |source|
ContactSource.create!(:name => source)
end

# Add contacts from Github
  GithubContact.new.get_contacts

