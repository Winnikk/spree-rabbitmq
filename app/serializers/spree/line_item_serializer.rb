# frozen_string_literal: true

module Spree
  class LineItemSerializer < ActiveModel::Serializer
    attributes :sku, :quantity, :price, :final_price, :size

    def final_price
      object.product&.price
    end

    def size
      # HACK: information about size, could be a method in the variant model
      object.variant&.height
    end
  end
end
