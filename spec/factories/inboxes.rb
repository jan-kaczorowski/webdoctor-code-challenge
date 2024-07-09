# frozen_string_literal: true

FactoryBot.define do
  factory :inbox do
    user
    unread_messages_count { 0 }
  end
end

# == Schema Information
#
# Table name: inboxes
#
#  id                    :integer          not null, primary key
#  unread_messages_count :integer
#  user_id               :integer
#
# Indexes
#
#  index_inboxes_on_user_id  (user_id)
#
