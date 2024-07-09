class Inbox < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :nullify

  def update_unread_messages_count
    update_column(:unread_messages_count, messages.where(read: false).count)
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
