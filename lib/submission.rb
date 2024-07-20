# frozen_string_literal: true

# CFP Submission
Submission = Data.define(:name, :email, :location, :title, :abstract, :bio,
                         :url, :notes, :talk_format, :audience_level, :state,
                         :description, :tags, :additional_info) do
  include Comparable
  SUBMISSIONS_FILE = './import/submissions.json'

  def id = Secret.new("#{title}-#{email}").sign

  def <=>(other) = title <=> other.title

  def self.all
    JSON.load_file(SUBMISSIONS_FILE, symbolize_names: true)
        .map { new(**_1.slice(*members)) }
  end

  def tag_list = Array(tags).map { "##{_1.downcase.gsub(' ', '-')}" }
  def export(filename) = File.write(filename, to_md)

  def to_md
    <<~MARKDOWN
      # #{title}

      Submission: `#{id}`, Tags: `#{tag_list.empty? ? '-' : tag_list.join('`, `')}`

      > #{abstract.gsub("\n", '')}

      #{description}
    MARKDOWN
  end

#   def to_md
#     <<~MARKDOWN
#       # #{title}
#
#       Author: #{name} (#{email}), Location: #{location},
#       Submission: `#{id}`, Tags: `#{tag_list.join('`, `')}`,
#       URL: #{url}, State: #{state}, Level: #{audience_level},
#       Format: #{talk_format}
#
#       > #{abstract.gsub("\n", '')}
#
#       #{description}
#
#       ## Bio
#
#       #{bio}
#
#       ## Notes
#
#       #{notes}
#
#       ## Additional Information
#
#       #{additional_info}
#     MARKDOWN
#   end
end
