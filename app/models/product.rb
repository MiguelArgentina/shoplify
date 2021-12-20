class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :price, numericality: {greater_than: 0, less_than: 10000000}
  has_many :line_items, dependent: :destroy
  monetize :price, as: :price_cents

  def to_s
    name
  end

  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end
  after_create do
    product = Stripe::Product.create({
                                       name: name
                                     })

    price = Stripe::Price.create({
                                   product: product.id,
                                   unit_amount: self.price,
                                   currency: 'usd'
                                 })

    update(stripe_product_id: product.id, stripe_price_id: price.id)

  end

  after_update :create_new_stripe_price, if: :saved_change_to_price?

  def create_new_stripe_price

    product = Stripe::Product.create({
                                       name: name
                                     })

    price = Stripe::Price.create({
                                   product: self.stripe_product_id,
                                   unit_amount: self.price,
                                   currency: 'usd'
                                 })

    update(stripe_price_id: price.id)
  end
end
