class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :outbox

  STANDARDIZED_MESSAGES = {
    lost_perscription: {
      fee: 10.0
    }
  }.freeze

  def self.standardized_messages
    STANDARDIZED_MESSAGES.each_with_object({}) do |(key, val), memo|
      val[:body] = I18n.t("messages.standardized_messages.#{key}", fee: val[:fee])
      memo[key] = val
    end
  end

  after_initialize do
    next unless previous_message && !inbox && !outbox

    self.inbox = previous_message.outbox.user.inbox
    self.outbox = previous_message.inbox.user.outbox
  end

  after_save do
    inbox.update_unread_messages_count
  end

  belongs_to :previous_message, class_name: 'Message', optional: true
  has_many :replies, class_name: 'Message', foreign_key: :previous_message_id

  validates :body, presence: true
  validates :body, length: { maximum: 500 }
  validate :verify_can_create_message

  def mark_read!
    update!(read: true)
  end

  def verify_can_create_message
    return unless outbox.user.is_patient
    return unless previous_message
    return if previous_message.created_at > 1.week.ago

    errors.add(:base, 'too late to reply')
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
