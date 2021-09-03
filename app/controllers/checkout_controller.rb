class CheckoutController < ApplicationController

  def create
    product = Product.find(params[:id])
      @session = Stripe::Checkout::Session.create({
        line_items: [{
          # TODO: replace this with the `price` of the product you want to sell
          name: product.name,
          amount: product.price,
          currency: 'usd',
          quantity: 1,
        }],
        payment_method_types: [
          'card',
        ],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
   respond_to do |format|
    format.js
   end
  end
end