# frozen_string_literal: true

class Message < ApplicationRecord
  MAX_CONTENT_LENGTH = 1000

  validates :original_content, length: {maximum: MAX_CONTENT_LENGTH}, presence: true
end
