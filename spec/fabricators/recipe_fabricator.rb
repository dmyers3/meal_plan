Fabricator(:recipe) do
  name { Faker::Food.dish }
  prep_time { Faker::Number.number(2) }
  cook_time { Faker::Number.number(2) }
  instructions { Faker::Lorem.paragraphs(2) }
end