class Member < ActiveRecord::Base

  # Validations
  validates_presence_of       :email,   :name
  validates_length_of         :email,   :minimum => 3
  validates_uniqueness_of     :email,   :case_sensitive => false
  validates_format_of         :email,   :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  validates_format_of         :website, :with => /^(http|https)/

  # Callbacks
  before_save :santize_attributes

  private

    def santize_attributes
      self.twitter = self.twitter.strip.gsub('@','')
    end

end
