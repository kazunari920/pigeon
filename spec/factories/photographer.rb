# frozen_string_literal: true

FactoryBot.define do
  factory :photographer do
    name { "#{Faker::Name.name} カメラマン" }
    email { Faker::Internet.email }
    sequence(:password, 'password_1')
    sequence(:password_confirmation, 'password_1')
    confirmed_at { Time.zone.now }
  end
end
