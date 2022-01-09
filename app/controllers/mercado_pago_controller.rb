class MercadoPagoController < ApplicationController
  # SDK de Mercado Pago
  require 'mercadopago'
  before_action :set_order
  
  def mp_payment
    #public:
    #TEST-94fde7e0-f023-4c71-aa99-b9908f77f094
    #acces token
    #TEST-8730493886441562-102901-f24bf10ddecd448cada9598198fc7f74-73311769
    # Agrega credenciales
puts create_items_for_preference
    sdk = Mercadopago::SDK.new('TEST-8730493886441562-102901-f24bf10ddecd448cada9598198fc7f74-73311769')

    # Crea un objeto de preferencia
    preference_data = {
      items: create_items_for_preference,
      payer: {
        name: @order.name,
        surname: nil,
        email: @order.email,
        date_created: DateTime.now(),
        phone: {
          area_code: '',
          number: '949 128 866'
        },
        
        identification: {
          type: 'DNI',
          number: '12345678'
        },

        shipments: {
          receiver_address: {
            street_name: 'Cuesta Miguel Armendáriz',
            street_number: '1004',
            zip_code: '11020'
          }
        }
      },
      back_urls: {
        success: 'http://127.0.0.1:3000/',
        failure: 'http://127.0.0.1:3000/mp',
        pending: 'http://127.0.0.1:3000/products/12'
      },
      auto_return: 'approved'
    }
    preference_response = sdk.preference.create(preference_data)
    @preference = preference_response[:response]


    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = @preference['id']
    set_order_preference(preference_id: @preference['id'])


  end

  def create_items_for_preference
    items = []
    @order.line_items.each do |li|
      items << {
        id: li.product.id,
        title: li.product.name,
        unit_price: li.price,
        currency_id: 'ARS',
        quantity: li.quantity,
        category_id: 'others'
      }
    end
    items
  end

  def set_order
    if params[:preference_id]
      @order = Order.find_by(preference_id: params[:preference_id])
    else
      @order = Order.find_by(id: params[:order_id])
    end  
  end

  def set_order_preference(preference_id:)
    @order.update(preference_id: preference_id)
  end
end