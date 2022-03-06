FactoryBot.define do
  factory :channels_user do
    association :channel
    association :user
  end
end
