class Post
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String, :required => true
  property :body, Text
  property :slug, String
  property :created_at, DateTime
  property :account_id, Integer
  before :create, :generate_slug
  
  belongs_to :account
  has_tags
  
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
end
