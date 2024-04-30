# frozen_string_literal: true


class ProcessFulfilledOrder
  include Sneakers::Worker

  FULFILLED_ORDERS_QUEUE_NAME = "fulfilled.orders"

  from_queue FULFILLED_ORDERS_QUEUE_NAME

  def work(msg)
    event_data = JSON.parse(msg)
    order = retrieve_order(event_data["name"])
    order.finalize!
    complete_shipments(event_data["shipments"])

    ack!
  rescue StandardError => e
    # Add logging mechanism
    reject!
  end

  private

  def retrieve_order(order_number)
    Spree::Order.find_by!(number: order_number)
  end

  def complete_shipments(shipments_data)
    shipments_data.each do |shipment_data|
      shipment = retrieve_shipment(shipment_data["number"])
      shipment.ship!
    end
  end

  def retrieve_shipment(shipment_number)
    Spree::Shipment.find_by(number: shipment_number)
  end
end
