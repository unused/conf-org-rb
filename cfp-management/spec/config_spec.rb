# frozen_string_literal: true

RSpec.describe Config do
  it 'provides submission file' do
    expect(Config.files.submission).to eq './spec/fixtures/submission.json'
  end

  it 'provides secrets file location' do
    expect(Config.files.secret_key).to eq './spec/fixtures/.secret'
  end

  it 'provides reviewers file location' do
    expect(Config.files.reviewers).to eq './spec/fixtures/reviewers.json'
  end

  it 'provides introduction template file location' do
    expect(Config.files.template).to eq './spec/fixtures/template.md'
  end

  it 'provides the output directory' do
    expect(Config.files.output).to eq './spec/tmp/output'
  end
end
