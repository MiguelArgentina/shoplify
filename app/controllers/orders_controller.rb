class OrdersController < ApplicationController

  def index
    @orders = nil
    @orders = Order.where(email: current_user.email).order(created_at: :desc) if current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    @order = Order.new(order_params)
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to order_pay_order_path(@order)
  end

  def choose_payment_method
    @order = Order.find(params[:order_id])
    @line_items = @order.line_items
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :address, :pay_method)
  end
end
