# Add sources

%w([github]).each do |source|
ContactSource.create!(:name => source)
end

# Add contacts from Github
GithubContact.new.get_contacts

[["San Francisco", "CA", "SF"], ["Seattle", "WA", "SEA"], ["Boston", "MA", "BOS"], ["Philadelphia", "PA", "PHL"]]. each do |city|
  Region.create(:city => city[0], :state => city[1], :nick_name => city[2])
end  

