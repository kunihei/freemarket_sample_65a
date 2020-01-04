FactoryBot.define do

  factory :user do
    nickname              {"test"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    last_name             {"テスト"}
    first_name            {"テスト"}
    last_name_kana        {"テスト"}
    first_name_kana       {"テスト"}
    birthday              {"2020-01-03"}
  end

end


