class Member
  include DataMapper::Resource
  include DataMapper::Validate
  attr_accessor :password, :password_confirmation

  # Properties
  property :id,               Serial
  property :name,             String
  property :email,            String
  property :employer,         String
  property :twitter,          String
  property :website,          String
  property :about,            Text
  property :published,        Boolean, :default => false

  # Validations
  validates_presence_of       :email,   :name
  validates_length_of         :email,   :min => 3, :max => 100
  validates_uniqueness_of     :email,   :case_sensitive => false
  validates_format_of         :email,   :with => :email_address
  validates_format_of         :website, :with => /^(http|https)/

  # Callbacks
  before :save, :santize_attributes

  private

    def santize_attributes
      self.twitter = self.twitter.strip.gsub('@','')
    end

end
