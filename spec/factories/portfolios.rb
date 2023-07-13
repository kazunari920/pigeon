# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio do
    title { 'MyString' }
    description { 'MyText' }
    photographer { nil }
  end
end
