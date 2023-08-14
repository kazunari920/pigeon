# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    sequence(:password, 'password_1')
    sequence(:password_confirmation, 'password_1')
    confirmed_at { Time.zone.now }
  end
end
