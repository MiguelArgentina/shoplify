class CheckoutController < ApplicationController

  def create

    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  line_items: @cart.collect { |item| item.to_builder.attributes! },
                                                  payment_method_types: [
                                                    'card',
                                                  ],
                                                  mode: 'payment',
                                                  success_url: success_url + '?session_id={CHECKOUT_SESSION_ID}',
                                                  cancel_url: failure_url,
                                                })
    respond_to do |format|
      format.js
    end
  end

  def success
    if params[:session_id].present?
      @purchased_items = []
      session_id = params[:session_id]
      session_with_expand =
        Stripe::Checkout::Session.retrieve({ id: session_id,
                                             expand: %w[payment_intent line_items] })
      session_with_expand.line_items.data.each_with_index do |line_item, index|
        line_item_data = {}
        line_item_data.merge!({product_name: line_item.description})
        line_item_data.merge!({quantity: line_item.quantity})
        line_item_data.merge!({amount: line_item.amount_total})
        line_item_data.merge!({currency: line_item.currency})
        @purchased_items << line_item_data
      end
    else
      redirect_to failure_path, alert: 'Not authorized'
    end
  end

  def failure
  end

end