FactoryBot.define do
  factory :review do
    title { "MyString" }
    artist { "MyString" }
    genre { "MyString" }
    body { "MyText" }
    user { nil }
  end
end
