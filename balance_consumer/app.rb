require 'sinatra'
require 'bunny'
require 'json'
require  'pry-byebug'
require_relative 'storage.rb'


set :port, 7171
response = ''

  connection = Bunny.new(
                          host:  'localhost',
                          port:  '5672',
                          vhost: '/',
                          user:  'guest',
                          pass:  'guest')
  connection.start

  channel = connection.create_channel
  queue = channel.queue('transaction')

  begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Received #{body}"
    
    response_json  =JSON.parse(body)

    deposit(response_json['value'],response_json['cpf'],response_json['name'])
  end
rescue Interrupt => _
  connection.close
  exit(0)
end
