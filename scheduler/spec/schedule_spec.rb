# frozen_string_literal: true

require_relative '../app'

RSpec.describe Schedule do
  subject { described_class.all.first }

  it 'has a title' do
    expect(subject.name).to eq('EuRuKo 2024')
  end
end

RSpec.describe EventDay do
  subject { Schedule.all.first.days.first }

  it 'first slot has start time of day' do
    time = subject.slots.first.start_time.strftime('%H:%M')
    expect(time).to eq(subject.start)
  end

  it 'subsequent slots start from previous slot end time' do
    time = subject.slots.last.start_time.strftime('%H:%M')
    expect(time).to eq('16:30')
  end
end

RSpec.describe EventSlot do
  subject { slot(:talk, 45, day) }

  it 'first slot has start time of day' do
    expect(subject.start_time.to_ft).to eq '09:00'
    expect(subject.end_time.to_ft).to eq '09:45'
  end

  it 'subsequent slots start from previous slot end time' do
    previous_slot = slot(:talk, 30, day)
    subject.previous_slot = previous_slot

    expect(subject.start_time.to_ft).to eq '09:30'
    expect(subject.end_time.to_ft).to eq '10:15'
  end

  private

  Day = Struct.new(:start_time)
  def day = Day.new(Time.parse('09:00'))

  def slot(type, duration, day = nil)
    described_class.new(type:, duration:, day:)
  end
end
