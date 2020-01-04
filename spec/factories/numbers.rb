FactoryBot.define do

  factory :number do
    tell              {Faker::Number.leading_zero_number(digits: 11)}
  end

end
