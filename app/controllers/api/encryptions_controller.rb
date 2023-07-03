module Api
  class EncryptionsController < ActionController::Base
    MAX_MESSAGE_LENGTH = 1000
    DEFALUT_ENCRYPTION_ALGO = 13

    skip_before_action :verify_authenticity_token, only: [:create]
    before_action :valid?, :save_original_message, only: [:create]
  
    def create  
      render json: { encrypted_message: encryption_service.rot13 }, status: :ok
    end
  
    private
  
    def encryption_service
      StringEncryption.new(message)
    end
  
    def message
      begin
        params.require(:string)
      rescue ActionController::ParameterMissing => e
        render_error("Required parameter is missing: #{e.param}")
      end
    end 
  
    def valid?
      render_error("Message should not exceed #{MAX_MESSAGE_LENGTH} characters.") unless valid_length?  
    end
  
    def valid_length?
      message.length <= MAX_MESSAGE_LENGTH
    end
  
    def save_original_message
      Message.find_or_create_by(original_content: message, encryption_alogrithem: DEFALUT_ENCRYPTION_ALGO) do |message|
        render_error(message.errors.full_messages.join(', ')) unless message.valid?
      end
    end
  
    def render_error(error_message)
      render json: { error: error_message }, status: :unprocessable_entity
    end
  end
end

