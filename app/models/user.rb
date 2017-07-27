class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :token, uniqueness: true, allow_nil: true
  validates :zip_code, presence: true
  validates_format_of :zip_code, :with => /\A\d{5}(-\d{4})?\z/, :message => "should be in the form 12345 or 12345-1234"
  validates_length_of :password, minimum: 8 
  has_secure_password
end