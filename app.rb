require 'sinatra'
require 'sinatra/namespace'
require_relative './boot'

configure :development do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'ads_development', pool: 2}
end

configure :production do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'ads_production', pool: 2}
end

class App < Sinatra::Base
  # set :root, File.dirname(__FILE__)
  register Sinatra::Namespace

  attr_reader :validation_result

  namespace '/api/v1' do
    before do
        content_type 'application/json'
    end

    get '/ads' do
      # AdSerializer.new(Ad.all.first).to_json
      serializer = AdSerializer.new(Ad.all)
      serializer.serialized_json
    end  

    post '/ads' do
      payload = JSON.parse(request.body.read, symbolize_names: true)
      byebug
      return error_message(validation_result.errors.messages.map(&:to_h)) unless valid?(payload)
      result = Ads::CreateService.new(payload).call
      if result.success?
        status 201
        AdSerializer.new(result.ad).to_json
      else
        error_message(result.ad)
      end
    end
  end

  def error_message(messages)
    status 422
    { error: messages }.to_json
  end

  def valid?(payload)
    @validation_result ||= AdContract.new.call(payload)
    @validation_result.success?
  end

end