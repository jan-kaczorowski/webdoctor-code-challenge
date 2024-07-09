# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    after(:create) do |user|
      create(:inbox, user:) #unless user.inbox
      create(:outbox, user:) #unless user.outbox
    end

    trait :being_admin do
      is_admin { true }
      is_doctor { false }
      is_patient { false }
    end

    trait :being_patient do
      is_admin { false }
      is_doctor { false }
      is_patient { true }
    end

    trait :being_doctor do
      is_admin { false }
      is_doctor { true }
      is_patient { false }
    end
  end
end
