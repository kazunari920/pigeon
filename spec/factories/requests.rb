FactoryBot.define do
  factory :request do
    association :user
    association :photographer

    name { 'test kun' }
    shooting_date { '2024-01-01' }
    shooting_location { '京都' }
    budget { 10000 }
    comment { 'test' }
    address { '東京都' }
    phone_number { '09012345678' }
    status { 0 }
    created_at { '2023-01-01 00:00:00' }
    updated_at { '2024-01-01 00:00:00' }
  end
end