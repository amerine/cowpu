xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "COWPU"
    xml.description "Central Oregon Web Professionals Usergroup"
    xml.link url_for(:index)

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link url_for(:posts, :show, :slug => post.slug)
      end
    end
  end
end
