# frozen_string_literal: true

# Introduction page
Introduction = Struct.new(:reviewer) do
  TEMPLATE = './import/introduction.md'

  def write(filename) = File.write(filename, to_md)

  def to_md
    File.read(TEMPLATE)
        .gsub('REVIEWER', reviewer.name)
        .gsub('SUBMISSIONURL', reviewer.submission_url)
        .gsub('SUBMISSIONSAFEURL', reviewer.submission_url.gsub('_', '\\_'))
  end
end
