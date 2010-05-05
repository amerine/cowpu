require File.dirname(__FILE__) + '/config/boot.rb'
require 'thor'
require 'padrino-core/cli/rake'

PadrinoTasks.init

task :import do
  require 'feed_tools'
  import_url = ENV["import_url"] || "http://haiku2.com/cowpu.xml"
  cowpu_feed = FeedTools::Feed.open(import_url)
  cowpu_feed.items.each do |item|
    title = item.title.gsub("Central Oregon Web Professionals Usergroup: ",'')
    Post.create(:title => title, :body => item.description, :created_at => item.published, :account_id => 1)
  end
end
