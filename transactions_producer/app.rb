require 'sinatra'
require_relative './user_transaction'
require 'json'
require 'pry-byebug'
require './publisher'
require_relative './validators'

set :port, 8181

post '/deposit' do
  content_type :json

  request_body = JSON.parse(request.body.read)

  valid = Validator.new
  pb = Publisher.new

  begin
    valid.validate_cpf(request_body['cpf'])
    valid.validate_value(request_body['value'])
    valid.validate_name(request_body['name'])

    response = User_transaction.from_json(request_body)

    pb.send_message(request_body.to_json)
    JSON.pretty_generate("{'transaction': true}")
  rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
    JSON.pretty_generate("{'transaction': #{e.message}}")
  end
end
