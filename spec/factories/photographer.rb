# frozen_string_literal: true

FactoryBot.define do
  factory :photographer do
    name { "#{Faker::Name.name} カメラマン" }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now } # 追加
  end
end
