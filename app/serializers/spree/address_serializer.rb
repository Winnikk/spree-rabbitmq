# frozen_string_literal: true

module Spree
  class AddressSerializer < ActiveModel::Serializer
    attributes :company, :first_name, :last_name, :email, :phone, :street, :city, :zip, :country

    def email
      object.user&.email
    end

    def street
      object.address1
    end

    def zip
      object.zipcode
    end

    def country
      object.country&.name
    end
  end
end
