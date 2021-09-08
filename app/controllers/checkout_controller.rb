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
        success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: failure_url,
      })
   respond_to do |format|
    format.js
   end
  end

  def success
    session_id = params[:session_id]
    @session = get_session_id(session_id)
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @session_with_expand = Stripe::Checkout::Session.retrieve({
                                                                   id: session_id,
                                                                   expand: %w[payment_intent line_items]
                                                                 })
  end

  def failure

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def get_session_id(session_id)
    Stripe::Checkout::Session.retrieve(session_id)
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.permit(:session_id)
  end
end