# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    inbox
    outbox
    body { Faker::Lorem.paragraph }
    read { false }
  end
end

# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  body                :text
#  read                :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  inbox_id            :integer
#  outbox_id           :integer
#  previous_message_id :integer
#
# Indexes
#
#  index_messages_on_inbox_id             (inbox_id)
#  index_messages_on_outbox_id            (outbox_id)
#  index_messages_on_previous_message_id  (previous_message_id)
#
