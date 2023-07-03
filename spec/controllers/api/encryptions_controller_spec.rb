# spec/controllers/api/encryptions_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::EncryptionsController, type: :controller do
  describe 'POST #create' do
    let(:valid_message) { 'Valid message' }
    let(:invalid_message) { 'a' * (Message::MAX_MESSAGE_LENGTH + 1) }

    context 'with a valid message' do
      before do
        post :create, params: { string: valid_message }
      end

      it 'returns the encrypted message' do
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('encrypted_message')
      end

      it 'creates a new Message with the original content' do
        expect(Message.last.original_content).to eq(valid_message)
      end
    end

    context 'with an invalid message' do
      before do
        post :create, params: { string: invalid_message }
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end

      it 'does not create a new Message' do
        expect(Message.count).to eq(0)
      end
    end

    context 'with a missing message parameter' do
      before do
        post :create
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end

      it 'does not create a new Message' do
        expect(Message.count).to eq(0)
      end
    end
  end
end
