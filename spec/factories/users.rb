FactoryBot.define do

  factory :user do
    nickname              {"test"}
    email                 {Faker::Internet.email}
    password              {"00000000"}
    last_name             {"テスト"}
    first_name            {"テスト"}
    last_name_kana        {"テスト"}
    first_name_kana       {"テスト"}
    birthday              {Faker::Date.in_date_period(year: 2018, month: 2)}
  end

end


