Fabricator(:review) do
  rating { Faker::Number.between(1, 5) }
  content { Faker::Lorem.paragraphs(3).join("\n\n") }
end
