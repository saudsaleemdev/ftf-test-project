# frozen_string_literal: true

class StringEncryptionService
  DEFALUT_ENCRYPTION_ALGO = 13

  attr_accessor :original_content, :message, :error

  def initialize(original_content)
    @original_content = original_content
  end

  def rot13
    Message.transaction do
      @message = Message.find_or_create_by!(original_content: original_content,
                                            encryption_alogrithem: DEFALUT_ENCRYPTION_ALGO)
      @message.update!(encrypted_content: encrypt_message)

      true
    rescue ActiveRecord::RecordInvalid => e
      @error = e.message

      false
    end
  end

  private

  def encrypt_message(algo: DEFALUT_ENCRYPTION_ALGO)
    original_content.chars.map do |char|
      if char =~ /[a-mA-M]/
        (char.ord + algo).chr
      elsif char =~ /[n-zN-Z]/
        (char.ord - algo).chr
      else
        char
      end
    end.join
  end
end
