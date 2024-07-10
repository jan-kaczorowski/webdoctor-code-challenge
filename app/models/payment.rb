class Payment < ApplicationRecord
  belongs_to :user

  enum state: { paid: 'paid', pending: 'pending', failed: 'failed' }

  validates :amount, presence: true
end

# == Schema Information
#
# Table name: payments
#
#  id      :integer          not null, primary key
#  amount  :decimal(10, 6)   not null
#  state   :string           default("pending"), not null
#  user_id :integer
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
