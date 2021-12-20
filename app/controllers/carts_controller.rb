class CartsController < ApplicationController
  def show
    @cart = @current_cart
    puts "--___---"
    puts @cart.line_items.inspect
    puts "--___---"
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end
end
