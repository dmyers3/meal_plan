Fabricator(:grocery_chain) do
  name { Faker::Lorem.words(2).join(" ") }
end