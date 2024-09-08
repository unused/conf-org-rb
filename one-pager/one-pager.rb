# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'sinatra'
  gem 'rackup'
  gem 'yaml'
end

set :views, '.'

INFOS = YAML.safe_load_file('speakers.yml', symbolize_names: true)

Hotel = Data.define(:name, :address, :phone, :location_url, :description)
Talk = Data.define(:type, :title, :additional_description, :day, :location, :time, :duration)
Info = Data.define(:name, :hotel, :accommodation, :image_url, :talks) do
  def _talks = talks.map { Talk.new(**_1) }
end

def fetch_info(name) = Info.new(**INFOS[:speakers].fetch(name))

get '/:name' do
  @assets_root = 'http://localhost:8000'
  @info = fetch_info params[:name].to_sym
  @hotel = Hotel.new(**INFOS[:hotels].fetch(@info.hotel.to_sym))

  erb :'template.html'
end

puts "Available speakers: #{INFOS[:speakers].keys}"

Sinatra::Application.run!
