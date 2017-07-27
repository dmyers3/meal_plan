require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:token) }
  it { should allow_value("12345").for(:zip_code) }
  it { should allow_value("12345-1234").for(:zip_code) }
  it { should_not allow_value("foo").for(:zip_code) }
  it { should_not allow_value("123456").for(:zip_code) }
  it { should_not allow_value("12345-645").for(:zip_code) }
end