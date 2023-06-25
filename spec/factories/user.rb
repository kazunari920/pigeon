FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      # 他の属性もここで定義します
    end
  end