ENV['RACK_ENV'] ||= 'development'
APP_ROOT = File.expand_path('../', __FILE__)
ENV['BUNDLE_GEMFILE'] ||= File.join(APP_ROOT, '/', 'Gemfile')
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# require 'pg'
# require 'active_support'

# DB = Sequel.postgres('ads_dev', user: 'postgres', password: '', host: 'localhost')

# Sequel::Model.plugin :validation_helpers
# Sequel::Model.plugin :timestamps, update_on_create: true
# Sequel.default_timezone = :utc

require './app/services/basic_service'

# current_dir = Dir.pwd
# Dir["#{current_dir}/models/*.rb"].each { |file| require file }

Dir[File.join(APP_ROOT, '/app/**/*.rb')].each do |f|
  require f
end 