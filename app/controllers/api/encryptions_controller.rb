# frozen_string_literal: true

module Api
  class EncryptionsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :original_content

    def create
      encryptions_service = StringEncryptionService.new(original_content)

      if encryptions_service.rot13
        render json: encryptions_service.message, serializer: EncryptionSerializer, status: :ok
      else
        render_error(encryptions_service.error)
      end
    end

    private

    def original_content
      @original_content ||= params.require(:string)
    rescue ActionController::ParameterMissing => e
      render_error("Required parameter is missing: #{e.param}")
    end

    def render_error(error)
      render json: {error: error}, status: :unprocessable_entity
    end
  end
end
