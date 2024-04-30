# frozen_string_literal: true

Spree::Order.class_eval do
  state_machine.after_transition to: :complete, do: :publish_completed_event

  private

  def publish_completed_event
    Publishers::Orders::CompletedEventPublisher.new.publish(serialized_order: serialize_order)
  end

  def serialize_order
    Spree::OrderSerializer.new(self).to_json
  end
end
