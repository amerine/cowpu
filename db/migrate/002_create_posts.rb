class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :slug
      t.text :body
      t.timetamps
    end
  end
  
  def self.down
    drop_table :posts
  end
end