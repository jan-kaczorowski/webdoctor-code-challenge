class AddUnreadMessagesCountToInboxes < ActiveRecord::Migration[7.1]
  def change
    add_column :inboxes, :unread_messages_count, :integer

    Inbox.find_each(batch_size: 100) { |inbox| inbox.update_unread_messages_count }
  end
end
