# frozen_string_literal: true

require 'rails_helper'

describe MessagesController do
  describe 'POST create' do
    let!(:previous_message) { create(:message) }
    let(:new_message_recipient) { previous_message.outbox.user }
    let(:new_message_sender) { previous_message.inbox.user }
    let(:params) do
      {
        message: {
          body: Faker::Company.bs,
          previous_message_id: previous_message.id
        }
      }
    end

    let(:created_message) { Message.find_by(previous_message: previous_message) }

    subject { post :create, params: }

    context 'when message is a reply to another message' do
      it 'creates an unread message' do
        subject
        expect(created_message.read).to be false
      end

      it 'creates message in an inbox of a sender of previous message' do
        subject
        expect(created_message.inbox.user).to eq(new_message_recipient)
      end

      it 'creates message in an outbox of a recipient of previous message' do
        subject
        expect(created_message.outbox.user).to eq(new_message_sender)
      end

      it 'increments an unread count on an inbox' do
        expect { subject }.to change {  new_message_recipient.inbox.reload.unread_messages_count }.by(1)
      end

      context 'when previous message is older than a week' do
        let!(:previous_message) { create(:message, created_at: 2.weeks.ago) }

        it 'does not create a new message' do
          subject
          expect(created_message).to be_nil
        end
      end
    end
  end

  describe 'GET show' do
    let!(:inbox) { create(:inbox) }
    let!(:message1) { create(:message, inbox:) }
    let!(:message2) { create(:message, inbox:) }
    let!(:message3) { create(:message, inbox:) }

    subject { get :show, params: { id: message1.id } }

    it 'decrements unread count in inbox when a message is shown' do
      expect { subject }.to change {  inbox.reload.unread_messages_count }.by(-1)
    end
  end
end
