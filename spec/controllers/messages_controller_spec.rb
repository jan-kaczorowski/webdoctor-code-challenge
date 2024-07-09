# frozen_string_literal: true

require 'rails_helper'

describe MessagesController do
  subject { Message.find_by(previous_message: previous_message) }

  describe 'CREATE' do
    let!(:previous_message) { create(:message) }
    let(:params) do
      {
        message: {
          body: Faker::Company.bs,
          previous_message_id: previous_message.id
        }
      }
    end

    before { post :create, params: }

    context 'when message is a reply to another message' do
      it 'creates an unread message' do
        expect(subject.read).to be false
      end

      it 'creates message in an inbox of a sender of previous message' do
        expect(subject.inbox.user).to eq(previous_message.outbox.user)
      end

      it 'creates message in an outbox of a recipient of previous message' do
        expect(subject.outbox.user).to eq(previous_message.inbox.user)
      end

      context 'when previous message is older than a week' do
        let!(:previous_message) { create(:message, created_at: 2.weeks.ago) }

        it 'does not create a new message' do
          expect(subject).to be_nil
        end
      end
    end
  end
end
