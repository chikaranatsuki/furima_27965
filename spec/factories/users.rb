FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              { '1a' + Faker::Internet.password(min_length: 7, max_length: 20) }
    password_confirmation {password}
    last_name             {"主税"}
    first_name            {"夏生"}
    last_name_kana        {"チカラ"}
    first_name_kana       {"ナツキ"}
    birth_date            { Faker::Date.between_except(from: 20.year.ago, to: 1.year.from_now, excepted: Date.today) }

  end
end