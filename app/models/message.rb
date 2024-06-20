class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :outbox

  validates :body, presence: true
  validates :body, length: { maximum: 500 }
end

# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text
#  read       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  inbox_id   :integer
#  outbox_id  :integer
#
# Indexes
#
#  index_messages_on_inbox_id   (inbox_id)
#  index_messages_on_outbox_id  (outbox_id)
#
