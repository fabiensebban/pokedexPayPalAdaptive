#app/controllers/pokemons_controller.rb
require 'net/http'
require 'yaml'


class PokemonsController < ApplicationController
#filtre qui s'execute à chaque début d'actionpour les actions spécifiés dans le only
	before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
	before_action :check_minimum
	before_action :authenticate_user!, only: [:new, :create]
	
	include PaypalHelper
	@@data = YAML.load_file('config/paypal.yml')

	def index 
		@pokemons = Pokemon.paginate(page: params[:page], per_page: 1)
						   .includes(:type)
	end

	def show
	end

	def new
		@pokemon = Pokemon.new
	end

	def create
		@pokemon = Pokemon.new pokemon_params
		if @pokemon.save
			redirect_to @pokemon
		else
			render 'new'
		end
	end

	def edit 
	end

	def update
		if @pokemon.update pokemon_params
			flash[:success] = "Le Pokemon #{@pokemon.name} a bien été mis à jour"
			redirect_to @pokemon
		else
			render 'edit'
		end
	end

	def destroy
		@pokemon.destroy
		redirect_to pokemons_path
	end

	# Pour accéder au fichier de config: 
	# 	#{Rails.Rails.application.paypal.LA_VARIABLE} 

	def buy

  		#@paypal_url = "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
		
		# uri = URI.parse("https://api.sandbox.paypal.com/v1/oauth2/token")
# 
		# http = Net::HTTP.new(uri.host, uri.port)
# 
		# request = Net::HTTP::Post.new(uri.request_uri)
		# request.set_form_data({"user[name]" => "testusername", "user[email]" => "testemail@yahoo.com"})
# 
		# response = http.request(request)
		# render :json => response.body

		@test2 = "https://www.sandbox.paypal.com/cgi-bin/webscr?" + createPayRequest.to_query
	end

	private 

	def pokemon_params
		params.require(:pokemon).permit(
			:name,
			:level,
			:number,
			:health_points,
			:type_id,
			move_ids: [])
	end

	def set_pokemon
		@pokemon = Pokemon.find params[:id]
	end

	def check_minimum
		count = Pokemon.count
		limit = 10
		flash[:danger] = "Vorte Pokedex contient moins de #{limit} Pokemons" if count < limit
	end

	def paypal_auth
		#require 'paypal-sdk-rest'
		#include PayPal::SDK::REST

		#@api = PayPal::SDK::REST.set_config(
		#    :ssl_options => {}, # Set ssl options
		#    :mode => :sandbox,  # Set :sandbox or :live
		#    :client_id     => Rails.application.secrets.paypal_client_id,
		#    :client_secret => Rails.application.secrets.paypal_secret )
		#@api.token
	end

	def paypal_acceptance
	end

	def paypal_execution
	end

end 