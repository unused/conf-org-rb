# frozen_string_literal: true

require 'digest'

# Secret managment
class Secret
  KEY_LENGTH = 25
  FILENAME = './.secret'

  def initialize(msg) = @msg = msg

  def self.init
    return if File.exist?(FILENAME)

    File.write(FILENAME, SecureRandom.hex(KEY_LENGTH))
  end

  def sign = Digest::SHA1.hexdigest("#{@msg}.#{key}")[0..12]

  private

  def key = @key ||= File.read(FILENAME)
end
