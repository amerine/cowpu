require 'config/boot'

task :import do
  require 'feed_tools'
  import_url = ENV["import_url"] || "http://www.cowpu.com/rss.xml"
  cowpu_feed = FeedTools::Feed.open(import_url)
  cowpu_feed.items.each do |item|
    attributes = {:title => item.title, :body => item.description, :created_at => item.published}
    begin
      uri = URI.parse(item.link)
      # This assumes that all of the URLs end with .html
      slug = uri.path.split('/').last.slice(0..-6)
    rescue
      # If we can't parse it for any reason, we'll use the title
      # we will assigned in a before_save method on the Post object
      slug = ""
    end
    attributes.merge!({:slug => slug})
    Post.create(attributes)
  end
end
