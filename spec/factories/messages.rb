# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    inbox
    outbox
    body { Faker::Lorem.paragraph }
    read { false }
  end
end
