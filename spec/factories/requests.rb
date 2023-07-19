FactoryBot.define do
  factory :request do
    user { nil }
    photographer { nil }
    message { "MyText" }
  end
end
