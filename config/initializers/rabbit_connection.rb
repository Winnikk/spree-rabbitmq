# frozen_string_literal: true

class RabbitConnection
  include Singleton
  attr_reader :connection

  def initialize
    @connection = Bunny.new(ENV['RMQ_URL'])
    @connection.start
  end

  def channel
    @channel ||= ConnectionPool.new do
      connection.create_channel
    end
  end
end
