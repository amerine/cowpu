class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name, :surname
      t.string :email
      t.string :crypted_password, :salt
      t.string :role
    end
  end
  
  def self.down
    drop_table :accounts
  end
end