# frozen_string_literal: true

# Application configuration
class Config
  SOURCE_FILE = 'config.yml'.freeze

  class << self
    def init(filename: nil)
      @config = YAML.safe_load_file(filename || SOURCE_FILE, symbolize_names: true)
    end

    def files
      Struct.new(:submission).new('test')
    end
  end
end
