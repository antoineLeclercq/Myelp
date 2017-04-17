Fabricator(:user) do
  full_name { Faker::Name.name }
  city { Faker::Address.city }
  state { Faker::Address.state_abbr }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
end
