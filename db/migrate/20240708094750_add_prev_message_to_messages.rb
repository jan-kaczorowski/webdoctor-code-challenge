class AddPrevMessageToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :previous_message, index: true
  end
end
