# frozen_string_literal: true

require_relative './schedule'
require_relative './timetable'

# Extend time by a formatted time for this project
class Time
  def to_ft = strftime('%H:%M')
end
