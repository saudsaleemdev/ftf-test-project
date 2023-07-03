# spec/models/message_spec.rb
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it 'validates the maximum length of original_content' do
      message = Message.new(original_content: 'a' * (Message::MAX_MESSAGE_LENGTH + 1))
      expect(message).to be_invalid
      expect(message.errors[:original_content]).to include("is too long (maximum is #{Message::MAX_MESSAGE_LENGTH} characters)")
    end

    it 'validates the presence of original_content' do
      message = Message.new
      expect(message).to be_invalid
      expect(message.errors[:original_content]).to include("can't be blank")
    end
  end

  describe 'before_save callback' do
    context 'when original_content length exceeds MAX_MESSAGE_LENGTH' do
      it 'adds an error to the original_content attribute' do
        message = Message.new(original_content: 'a' * (Message::MAX_MESSAGE_LENGTH + 1))
        expect { message.save }.to change { message.errors[:original_content] }
      end
    end

    context 'when original_content length is within MAX_MESSAGE_LENGTH' do
      it 'does not add any error to the original_content attribute' do
        message = Message.new(original_content: 'Valid content')
        expect { message.save }.not_to change { message.errors[:original_content] }
      end
    end
  end
end
