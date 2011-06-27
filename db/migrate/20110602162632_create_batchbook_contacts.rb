class CreateBatchbookContacts < ActiveRecord::Migration
  def self.up
    create_table :batchbook_contacts do |t|
      t.integer :batchbook_id
      t.string :first_name
      t.string :last_name      
      t.boolean :primary
      t.string :label
      t.integer :location_id
      t.string :email
      t.string :website
      t.string :phone
      t.string :cell
      t.string :state
      t.string :city
      t.string :postal_code
      t.string :country                                          
      t.timestamps
    end
  end

  def self.down
    drop_table :batchbook_contacts
  end
end
