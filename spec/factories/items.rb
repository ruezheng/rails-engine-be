FactoryBot.define do
  factory :item do
    name { "#{Faker::Coffee.blend_name} from #{Faker::Coffee.origin}" }
    description { Faker::Coffee.note }
    unit_price { Faker::Number.between(from: 4, to: 50) }
  end
end