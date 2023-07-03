class StringEncryption
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def rot13
    encrypted_message = ""
  
    message.each_char do |char|
      if char =~ /[a-mA-M]/
        encrypted_message << (char.ord + 13).chr
      elsif char =~ /[n-zN-Z]/
        encrypted_message << (char.ord - 13).chr
      else
        encrypted_message << char
      end
    end

    encrypted_message
  end
end