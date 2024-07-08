class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end

  def new
    @previous_message_id = params[:previous_message_id]
    @message = Message.new
  end

  def create
    puts params.inspect

    message = Message.create(messages_params)

    if message.valid?
      redirect_to messages_path,
                  flash: { success: 'message created' }
    else
      redirect_to new_message_path(previous_message_id: message.previous_message_id),
                  flash: { error: message.errors.full_messages.join(', ') }
    end
  end

  private

  def messages_params
    params.require(:message).permit(:previous_message_id, :body)
  end
end
