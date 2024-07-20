# frozen_string_literal: true

require 'json'
require 'yaml'
require 'securerandom'

require_relative './config'
require_relative './secret'
require_relative './submission'
require_relative './reviewer'
require_relative './introduction'

# Main application, manages flow of process.
class App
  def call
    prepare_env
    export_submissions
    generate
  end

  private

  def prepare_env
    Secret.init

    @submissions = Submission.all
    @reviewers = Reviewer.all
  end

  def export_submissions
    @submissions.each do |submission|
      filename = markdown_file submission
      next if File.exist? filename

      submission.export filename
    end
  end

  def generate
    @reviewers.each { generate_report _1 }
  end

  def generate_report(reviewer)
    report_file = "./export/report-#{reviewer.id}.md"
    Introduction.new(reviewer).write report_file

    # @submissions.sort.each do
    @submissions.shuffle.each do
      `echo -e "\n\\pagebreak\n" >> #{report_file}`
      `cat #{markdown_file(_1)} >> #{report_file}`
    end
  end

  def markdown_file(context) = "./export/submissions/#{context.id}.md"
end
