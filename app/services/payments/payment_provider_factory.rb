#
# Application supports multiple payment providers identified by id. Default one is very flaky one that sometimes processes payment and sometimes not. You
# call PaymentProviderFactory.provider(:flaky) to get instance of FlakyPaymentProvider. Or you can register other providers.
#
class Payments::PaymentProviderFactory
  class << self
    def register(id, provider_class)
      @providers << provider_class
    end

    def provider(id = nil)
      (self.providers[id] || self.providers.values&.first).new
    end

    private

    def providers
      @providers ||= {
        flaky: Payments::FlakyPaymentProvider
      }
    end
  end
end
