Fabricator(:tag_category) do
  name { Faker::Lorem.words(2).join(" ") }
end