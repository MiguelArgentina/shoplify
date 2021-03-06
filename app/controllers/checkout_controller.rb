class CheckoutController < ApplicationController

  def create
#MP:
#public:
#TEST-94fde7e0-f023-4c71-aa99-b9908f77f094
#acces token
#TEST-8730493886441562-102901-f24bf10ddecd448cada9598198fc7f74-73311769
    order = Order.find_by(id: params[:order_id])
    items = []
    order.line_items.each do |line_item|
      items << line_item.product.to_builder.attributes!
    end
    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  line_items: items,
                                                  allow_promotion_codes: true,
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
      session.delete(:cart)
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