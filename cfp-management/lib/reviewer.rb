# frozen_string_literal: true

# Reviewer
Reviewer = Data.define(:name, :document_url, :submission_url) do
  SOURCE_FILE = './import/reviewer.yaml'

  def id = Secret.new(name).sign

  def self.all
    YAML.safe_load_file(SOURCE_FILE, symbolize_names: true)
        .map { new(**_1.slice(*members)) }
  end
end
