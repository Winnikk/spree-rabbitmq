# frozen_string_literal: true

module Publishers
  module Orders
    class CompletedEventPublisher
      ORDERS_EXCHANGE_NAME = 'syncomm'
      ORDERS_QUEUE_NAME = 'orders'
      ORDERS_QUEUE_OBJECT_TYPE = 'order'
      ORDERS_QUEUE_ROUTING_KEY = 'store'

      def publish(serialized_order:)
        RabbitConnection.instance.channel.with do |channel|
          exchange = channel.headers(ORDERS_EXCHANGE_NAME, durable: true)
          exchange.publish(
            serialized_order,
            headers: {
              object_type: ORDERS_QUEUE_OBJECT_TYPE,
              routing_key: ORDERS_QUEUE_ROUTING_KEY
            }
          )
        end
      end
    end
  end
end
