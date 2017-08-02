require 'rails_helper'

describe StripeWrapper::Charge do
  context "with valid card" do
    it "charges card successfully" do
      VCR.use_cassette('valid_stripe_charge') do
        token = "tok_visa"
        response = StripeWrapper::Charge.create(amount: 300, source: token, description: "Test Charge")
        expect(response).to be_successful
      end
    end
  end
  
  context "with invalid card" do
      let(:token) { "tok_chargeDeclined" }
      
      it "does not charge the card successfully" do
        VCR.use_cassette('invalid_stripe_charge') do
          response = StripeWrapper::Charge.create(amount: 300, source: token, description: "Test Charge") 
          expect(response).not_to be_successful
        end
      end
      
      it "contains an error message" do
        VCR.use_cassette('invalid_stripe_charge') do
          response = StripeWrapper::Charge.create(amount: 300, source: token, description: "Test Charge")
          expect(response.error_message).to eq("Your card was declined.")
        end
      end
  end
end

describe StripeWrapper::Customer do
  context "with valid card" do
    it "creates customer successfully" do
      VCR.use_cassette('valid_stripe_customer') do
        token = "tok_visa"
        dan_email = Fabricate.attributes_for(:user)[:email]
        response = StripeWrapper::Customer.create(email: dan_email, source: token)
        expect(response).to be_successful
      end
    end
  end
  
  context "with invalid card" do
      let(:token) { "tok_chargeDeclined" }
      let(:dan_email) { Fabricate.attributes_for(:user)[:email] }
      
      it "does not create the customer successfully" do
        VCR.use_cassette('invalid_stripe_customer') do
          response = StripeWrapper::Customer.create(email: dan_email, source: token) 
          expect(response).not_to be_successful
        end
      end
      
      it "contains an error message" do
        VCR.use_cassette('invalid_stripe_customer') do
          response = StripeWrapper::Customer.create(email: dan_email, source: token)
          expect(response.error_message).to eq("Your card was declined.")
        end
      end
  end
end