class CreateGithubContacts < ActiveRecord::Migration
  def self.up
    create_table :contact_sources do |t|
       t.string :name
    end
    
    create_table :github_contacts do |t|
       t.string :gravatar_id 
       t.string :company
       t.string :name
       t.datetime :created_at
       t.string :location
       t.integer :public_repo_count
       t.integer :public_gist_count
       t.string :blog
       t.integer :following_count
       t.string :type
       t.integer :followers_count
       t.string :login
       t.boolean :permission
       t.string :email
       t.integer :contact_source_id
       t.updated_at :datetime
    end
    
    add_index :github_contacts, :login
    add_index :github_contacts, :following_count
    add_index :github_contacts, :followers_count
    add_index :github_contacts, :public_repo_count  
    add_index :github_contacts, :public_gist_count    
    add_index :github_contacts, :created_at
    add_index :github_contacts, :contact_source_id
    
  end

  def self.down
    drop_table :github_contacts
  end
end
