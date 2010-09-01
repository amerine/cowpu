class Post < ActiveRecord::Base
  before_create :generate_slug
  after_save :build_rss
  
  belongs_to :account
  
  named_scope :recent_posts, :limit => 5, :order => "created_at DESC"
  
  def generate_slug
    unique = false
    count = 0
    while !unique
      new_slug = count > 0 ? title.to_slug + "-#{count}" : title.to_slug
      unique = Post.count(:slug => new_slug) > 0 ? false : true
      count += 1
    end
    self.slug = new_slug
  end
  
  def build_rss
    feedr = Padrino.root('public','system','feed.xml')
    out = ''
    xml = Builder::XmlMarkup.new(:indent=>2,:target=>out)
    xml.instruct! :xml, :version => "1.0"
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title "COWPU"
        xml.description "Central Oregon Web Professionals Usergroup."
        xml.link "http://cowpu.com"

        Post.all(:limit => 10,:order => "created_at desc").each do |post|
          xml.item do
            xml.title post.title
            xml.link "http://cowpu.com/#{post.slug}"
            xml.description { xml.cdata!(post.body) }
            xml.pubDate post.created_at.to_s
            xml.guid "http://cowpu.com/#{post.slug}"
          end
        end
      end
    end

    File.open(feedr,'w'){|f| f.write(out) }
  end
end
