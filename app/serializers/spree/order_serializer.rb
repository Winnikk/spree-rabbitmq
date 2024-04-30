# frozen_string_literal: true

module Spree
  class OrderSerializer < ActiveModel::Serializer
    attributes :number, :channel, :item_total, :adjustment_total, :total, :payment_total,
               :currency, :state, :shipping_method, :created_at, :updated_at, :payment_state,
               :shipment_state, :created_by

    has_one :billing_address, serializer: Spree::BillingAddressSerializer
    has_one :shipping_address, serializer: Spree::AddressSerializer

    has_many :line_items, serializer: Spree::LineItemSerializer

    def shipping_method
      # HACK: first shipping method name
      object.shipments.first&.shipping_method&.name
    end

    def created_by
      object.created_by&.email
    end
  end
end
