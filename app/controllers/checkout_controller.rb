class CheckoutController < ApplicationController

  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  line_items: [{
                                                    price: product.stripe_price_id,
        quantity: 1,
                                                  }],
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

  end

  def failure
  end


end