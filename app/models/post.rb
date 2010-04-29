class Post
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String
  property :body, Text
  property :slug, String
  property :created_at, DateTime
  before :save, :generate_slug
  
  def generate_slug
    if !self.id
      unique_slug = false
      new_slug = self.title.to_slug
      counter = 0
      while !unique_slug
        counter += 1
        if Post.count(:slug => new_slug) > 0
          new_slug = "#{new_slug}-#{counter}"
        else
          unique_slug = true
        end
      end
      self.slug = new_slug
    end
  end
  
end
