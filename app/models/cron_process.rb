class CronProcess
  
  # updates all contacts in the database using delayed job
  
  def update_contacts
    GithubContact.all.each { |x| x.delay.update_contact}
  end
  
end