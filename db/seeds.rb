# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

6.times do
  Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
end
