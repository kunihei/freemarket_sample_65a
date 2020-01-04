FactoryBot.define do

  factory :address do
    last_name             {"テスト"}
    first_name            {"テスト"}
    last_name_kana        {"テスト"}
    first_name_kana       {"テスト"}
    postcode              {"123-4567"}
    city                  {"テスト"}
    block                 {"テスト"}
    building              {"テスト"}
    tell                  {Faker::Number.leading_zero_number(digits: 11)}
  end

end


