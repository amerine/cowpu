class Post
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String, :required => true, :unique => true
  property :body, Text
  property :slug, String
  property :created_at, DateTime
  before :save, :generate_slug
  
  def generate_slug
    if slug.nil? || slug.empty?
      self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
    end
  end
end
