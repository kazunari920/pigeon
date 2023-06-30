FactoryBot.define do
  factory :photographer do
    name { "#{Faker::Name.name} カメラマン" }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now } #追加

  end
end
