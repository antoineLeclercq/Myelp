# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

6.times do
  Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
end

antoine = Fabricate(:user, email: 'antoine@example.com', full_name: 'Antoine Leclercq', password: 'antoine', city: 'New York', state: 'NY')
Fabricate(:review, user: antoine, business: Business.last, content: 'Awesome place!', rating: 5)
Fabricate(:review, user: antoine, business: Business.second, content: 'Great place!', rating: 4)
Fabricate(:review, user: antoine, business: Business.first, content: 'I love it there!', rating: 5)

test_user = Fabricate(:user, email: 'test@test.com', full_name: 'Test User', password: 'password')
