class DropLangsSkillsRolesTables < ActiveRecord::Migration
  def self.up
    drop_table :languages
    drop_table :skills
    drop_table :roles
  end

  def self.down
    create_table :languages do |t|
      t.name :string
      t.belongs_to :polyglot, :polymorphic => true
    end
    create_table :roles do |t|
      t.name :string
      t.belongs_to :rolable, :polymorphic => true
    end
    create_table :skills do |t|
      t.name :string
      t.belongs_to :skillable, :polymorphic => true
    end
  end
end
