FactoryBot.define do
  factory :user do
    nickname              {Faker::Name}
    email                 {"test@example"}
    password              {"000000"}
    password_confirmation {password}
  end
end