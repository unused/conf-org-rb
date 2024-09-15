# frozen_string_literal: true

require 'yaml'
require 'time'

CfpTalk = Data.define(:title) do
  def self.load
    YAML.safe_load_file('cfp-details.yaml', symbolize_names: true).map do |talk|
      new(**talk)
    end
  end

  def self.generator
    Enumerator.new do |gen|
      talks = load.shuffle.each
      loop do
        gen << talks.next
      rescue StopIteration
        talks.rewind
        gen << talks.next
      end
    end
  end
end

Schedule = Data.define(:name, :description, :days) do
  def initialize(**kwargs)
    kwargs[:days]&.map! { EventDay.new(**_1) }
    super(**kwargs)
  end

  def self.all
    Dir.glob('schedules/_*.yaml').then do |files|
      files.map { new(**YAML.safe_load_file(_1, symbolize_names: true)) }
    end
  end

  def summary = EventSummary.new(event: self)
end

EventDay = Data.define(:description, :start, :slots) do
  def initialize(**kwargs)
    kwargs => {slots:}
    slots&.map! { EventSlot.new(**_1.merge(day: self)) }
    slots&.each_cons(2) { |a, b| b.previous_slot = a }

    super(**kwargs)
  end

  def start_time
    Time.parse(start)
  end
end


class EventSlot
  attr_reader :type, :description, :speaker, :duration
  attr_accessor :previous_slot

  def initialize(type:, duration:, day:, description: nil, speaker: nil, image: nil)
    @type = type
    @duration = duration
    @day = day
    @description = description
    @speaker = speaker
    @image = image
  end

  # def self.random = (@cfp_talks ||= CfpTalk.generator).next
  def self.random = (@cfp_talks ||= CfpTalk.load).sample

  def description
    return random_title if @description == '...'

    @description
  end

  def random_title = "#{self.class.random.title} (?)"

  def start_time
    @previous_slot&.end_time || @day.start_time
  end

  def end_time
    start_time + (@duration * 60)
  end

  def image = @image || 'no-image.png'
end

EventSummary = Data.define(:event) do
  def slots = event.days.map(&:slots).flatten
  def keynotes_count = slots.count { _1.type == 'keynote' }
  def talks_count = slots.count { _1.type == 'talk' }
  def workshops_count = slots.count { _1.type == 'workshop' }
  def panels_count = slots.count { _1.type == 'panel' }
  def speakers_count = keynotes_count + talks_count
end
