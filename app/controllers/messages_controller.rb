class MessagesController < ApplicationController
  before_action :set_params_for_standardized_msg, only: :create

  def show
    @message = Message.find(params[:id])
    @message.mark_read!
  end

  def new
    @previous_message_id = params[:previous_message_id]
    @message = Message.new
  end

  def create
    message = Message.create(messages_params)

    if message.valid?
      Payment.create!(amount: @std_message[:fee], user: message.outbox.user) if @std_message

      redirect_to messages_path,
                  flash: { success: 'message created' }
    else
      redirect_to new_message_path(previous_message_id: message.previous_message_id),
                  flash: { error: message.errors.full_messages.join(', ') }
    end
  end

  private

  def set_params_for_standardized_msg
    return unless params.key?(:standardized_message_id)

    @std_message = Message.standardized_messages.fetch(params[:standardized_message_id].to_sym)
    params[:message][:body] = @std_message[:body]
    params.delete(:standardized_message_id)
  end

  def messages_params
    params.require(:message).permit(:previous_message_id, :body)
  end
end
