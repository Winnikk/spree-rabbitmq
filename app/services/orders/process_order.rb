# frozen_string_literal: true

module Orders
  class ProcessOrder
    def call(order_number:, shipment_numbers:)
      order = retrieve_order(order_number)
      order.finalize!
      complete_shipments(shipments_number)
    end

    private

    def retrieve_order(order_number)
      ::Spree::Order.find_by!(number: order_number)
    end

    def complete_shipments(shipments_number)
      shipments_number.each do |number|
        shipment = retrieve_shipment(number)
        shipment.ship!
      end
    end

    def retrieve_shipment(shipment_number)
      ::Spree::Shipment.find_by(number: shipment_number)
    end
  end
end