# frozen_string_literal: true

# Background job responsible for processing payment on an order
class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, pay_type_params)
    order.charge!(pay_type_params)
  end
end
