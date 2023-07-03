class Message < ApplicationRecord
  MAX_MESSAGE_LENGTH = 1000

  validates :original_content, length: { maximum: MAX_MESSAGE_LENGTH }, presence: :true
  before_save :check_content_length

  private
  def check_content_length
    if original_content.present? && original_content.length >= MAX_MESSAGE_LENGTH
      errors.add(:original_content, "is too long (maximum is #{MAX_MESSAGE_LENGTH} characters)")
      throw :abort
    end
  end
end
