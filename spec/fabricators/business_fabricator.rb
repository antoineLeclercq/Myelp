Fabricator(:business) do
  name { Faker::Company.name }
  street { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state_abbr }
  zipcode { Faker::Address.zip.slice(0..4) }
  area { Faker::Lorem.word }
  phone { 1112224444 }
end
