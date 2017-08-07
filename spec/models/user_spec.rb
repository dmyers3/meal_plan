require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value("12345").for(:zip_code) }
  it { should allow_value("12345-1234").for(:zip_code) }
  it { should_not allow_value("foo").for(:zip_code) }
  it { should_not allow_value("123456").for(:zip_code) }
  it { should_not allow_value("12345-645").for(:zip_code) }
  it { should have_many(:recipes) }
  it { should have_many(:tags) }
  it { should have_many(:meal_plans) }
  
  describe "#assign_token" do
    it "assigns token" do
      dan = Fabricate(:user)
      dan.assign_token
      expect(dan.reload.token).not_to be_nil
    end
  end
end