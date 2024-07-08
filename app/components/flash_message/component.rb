module FlashMessage
  class Component < ::ViewComponent::Base
    attr_reader :type, :message

    def initialize(type:, message:)
      @type = type.to_sym
      @message = message
    end

    private

      def color_classes
        case @type
        when :success
          'alert alert-success'
        when :error
          'alert alert-danger'
        when :warning
          'alert alert-warning'
        else
          'alert alert-info'
        end
      end
  end
end