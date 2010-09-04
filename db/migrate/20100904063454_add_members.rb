class AddMembers < ActiveRecord::Migration
  def self.up
    create_table :members, :force => true do |t|
      t.string :email, :name, :employer, :twitter, :website
      t.text :about
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end