# frozen_string_literal: true

Sneakers.configure(
  connection: RabbitConnection.instance.connection,
  exchange: 'syncomm',
  exchange_type: :header
)
