# frozen_string_literal: true

require 'bundler/inline'

gemfile(true) do
  source 'https://rubygems.org'

  gem 'sinatra'
  gem 'rackup'
end

require_relative 'app'

class AppSrv < Sinatra::Base
  set :public_folder, 'public'

  get '/' do
    @schedules = Schedule.all
    erb :index
  end

  get '/program/:day' do
    @day = Integer(params[:day]).clamp(1, 3)
    @timetable = TimeTable.for(Schedule.all, @day)
    erb :program
  end

  run!
end
