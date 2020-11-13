FactoryBot.define do
  factory :event do
    sequence(:what) { |n| "Event #{n}" }
  end
end
