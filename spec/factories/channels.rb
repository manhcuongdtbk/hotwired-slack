FactoryBot.define do
  factory :channel do
    name { Faker::Internet.slug }
  end
end
