FactoryBot.define do
  factory :message do
    user { nil }
    request { nil }
    content { "MyText" }
  end
end
