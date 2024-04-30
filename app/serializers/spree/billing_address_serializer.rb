# frozen_string_literal: true

module Spree
  class BillingAddressSerializer < AddressSerializer
    attributes :vat_id

    def vat_id
      # HACK: that information is taken based on billing country zone
      object.country&.zone&.first&.id
    end
  end
end
