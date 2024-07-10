# frozen_string_literal: true

class PaymentsCapturerJob < ActiveJob::Base

  def perform
    Payment.where(state: 'pending')
           .where("created_at < ?", 1.minute.ago)
           .find_each { |payment| Payments::PaymentCapturer.capture!(payment) }
  end
end
