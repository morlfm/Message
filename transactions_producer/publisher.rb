require 'bunny'

class Publisher
  def send_message(message)
    connection = Bunny.new(
      host: 'localhost',
      port: '5672',
      vhost: '/',
      user: 'guest',
      pass: 'guest'
    )
    connection.start

    channel = connection.create_channel
    queue = channel.queue('transaction')

    channel.default_exchange.publish(message, routing_key: queue.name, content_type: 'application/json')
    puts " [x] Sent ‘Message'"
    connection.close
  end
end
