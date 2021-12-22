class MercadoPagoController < ApplicationController
  # SDK de Mercado Pago
  require 'mercadopago'

  def mp_payment
    puts "mp_payment"
    #public:
    #TEST-94fde7e0-f023-4c71-aa99-b9908f77f094
    #acces token
    #TEST-8730493886441562-102901-f24bf10ddecd448cada9598198fc7f74-73311769
    # Agrega credenciales

    sdk = Mercadopago::SDK.new('TEST-8730493886441562-102901-f24bf10ddecd448cada9598198fc7f74-73311769')

    # Crea un objeto de preferencia
    preference_data = {
      items: [
        {
          title: 'Mi producto',
          unit_price: 75.56,
          quantity: 1
        }
      ],
      payer: {
        name: 'Charles',
        surname: 'Luevano',
        email: 'charles@hotmail.com',
        date_created: '2018-06-02T12:58:41.425-04:00',
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


  end
end