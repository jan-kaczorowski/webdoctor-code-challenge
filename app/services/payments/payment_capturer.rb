class Payments::PaymentCapturer
  class PaymentError < StandardError; end

  def self.capture!(payment)
    ::Payments::PaymentProviderFactory.provider.debit(payment.amount)
    payment.update!(state: 'paid')
    true
  rescue StandardError => e
    Rails.logger.info("Capturing payment ID#{payment.id} failed. Details: #{e.message}")
    false
  end
end
