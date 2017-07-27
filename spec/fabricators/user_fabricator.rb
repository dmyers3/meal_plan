Fabricator(:user) do
  email { Faker::Internet.email }
  password { 'password' }
  zip_code { Faker::Address.zip }
  paid_member? { false }
end

Fabricator(:paid_user, from: :user) do
  paid_member? { true }
end