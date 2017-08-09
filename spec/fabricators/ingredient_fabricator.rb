Fabricator(:ingredient) do
  name { Faker::Food.ingredient }
end