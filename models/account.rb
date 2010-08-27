class Account < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  # Validations
  validates_presence_of       :email, :role
  validates_presence_of       :password,                          :if => :password_required
  validates_presence_of       :password_confirmation,             :if => :password_required
  validates_length_of         :password, :minimum => 4,   :if => :password_required
  validates_confirmation_of   :password,                          :if => :password_required
  validates_length_of         :email,    :minimum => 3
  validates_uniqueness_of     :email
  validates_format_of         :role,     :with => /[A-Za-z]/

  # Callbacks
  before_save :generate_password
  
  has_many :posts

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(email, password)
    account = first(:conditions => { :email => email }) if email.present?
    account && account.password_clean == password ? account : nil
  end

  ##
  # This method is used from AuthenticationHelper
  #
  def self.find_by_id(id)
    get(id) rescue nil
  end

  ##
  # This method is used for retrive the original password.
  #
  def password_clean
    crypted_password.decrypt(salt)
  end

  private
    def generate_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new?
      self.crypted_password = password.encrypt(self.salt)
    end

    def password_required
      crypted_password.blank? || !password.blank?
    end
end
