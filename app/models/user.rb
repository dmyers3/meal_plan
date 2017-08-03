class User < ActiveRecord::Base
  has_many :recipes
  validates :email, uniqueness: true, presence: true
  validates :zip_code, presence: true
  validates_format_of :zip_code, :with => /\A\d{5}(-\d{4})?\z/, :message => "should be in the form 12345 or 12345-1234"
  validates_length_of :password, minimum: 8 
  has_secure_password
  
  def assign_token
    generated_token = SecureRandom.urlsafe_base64
    self.update_column(:token, generated_token)
  end
  
end