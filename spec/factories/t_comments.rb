FactoryBot.define do
  factory :t_comment do
    user_id { 1 }
    item_id { 1 }
    text { "MyText" }
  end
end
