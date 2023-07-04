# frozen_string_literal: true

module Api
  class EncryptionsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :check_content_param

    def create
      encryption_service = StringEncryption.new(@content)

      return render_error(encryption_service.error) unless encryption_service.rotate

      render json: encryption_service.message, serializer: EncryptionSerializer, status: :ok
    end

    private

    def check_content_param
      @content = params.require(:content)
    rescue ActionController::ParameterMissing
      render_error("Content param is missing")
    end

    def render_error(error)
      render json: {error: error}, status: :unprocessable_entity
    end
  end
end
