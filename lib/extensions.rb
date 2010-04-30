String.class_eval do

  def to_slug
    self.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

end
