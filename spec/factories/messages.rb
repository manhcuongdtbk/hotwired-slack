FactoryBot.define do
  factory :message do
    association :channel
    association :user
    body { Faker::Lorem.sentence }
  end
end
