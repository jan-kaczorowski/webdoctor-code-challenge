# frozen_string_literal: true

class PaymentsCapturerJob < ActiveJob::Base

  def perform
    Payment.where(state: 'pending').find_each { |payment| capture_payment(payment) }
  end

  private

  def capture_payment(payment)
    Payments::PaymentProviderFactory.provider.debit(payment.amount)
    payment.update!(state: 'paid')
  rescue StandardError => e
    Rails.logger.info("Capturing payment ID#{payment.id} failed. Details: #{e.message}")
  end
end
