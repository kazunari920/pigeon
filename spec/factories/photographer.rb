FactoryBot.define do
    factory :photographer do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      password { 'password' }
      password_confirmation { 'password' }
      # 他の属性もここで定義します
    end
  end
