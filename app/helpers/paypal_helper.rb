module PaypalHelper
	
	@@data = YAML.load_file('config/paypal.yml')

	def createPayRequest
		values = {
		    :business => @@data['business_account'],
		    :cmd => '_cart',
		    :upload => 1,
		    :return => "http://localhost:3000/pokemons",
		    :invoice => "123"
		    # IPN URL :notify_url => ''
		  }
	    values.merge!({
	      "amount_1" => "11",
	      "item_name_1" => "pikachu",
	      "item_number_1" => "987",
	      "quantity_1" => "1"
	    })

	    return values
	end
end 