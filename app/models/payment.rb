class Payment < ApplicationRecord
  belongs_to :user
end

# == Schema Information
#
# Table name: payments
#
#  id      :integer          not null, primary key
#  user_id :integer
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
