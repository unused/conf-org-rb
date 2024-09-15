# frozen_string_literal: true

# Time Table to summarize and prepare the schedule for rendering.
class TimeTable
  def initialize(tracks) = @tracks = tracks
  def self.for(schedule, day) = new(schedule.map { _1.days[day - 1] })
  def slots_by_time = slots.group_by(&:start_time)
  def slots = @tracks.flat_map(&:slots).select(&method(:select))
  def select(slot) = %w[workshop keynote talk].include?(slot.type)
end
