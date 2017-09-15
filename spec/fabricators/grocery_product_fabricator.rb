Fabricator(:grocery_product) do
  name { Faker::Lorem.words(2).join(" ") }
  unit { "oz" }
  quantity { Faker::Number.between(1,20) }
  current_price { Faker::Number.between(100,500) }
  reg_price { Faker::Number.between(500,999) }
end