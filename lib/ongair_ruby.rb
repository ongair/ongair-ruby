require "ongair_ruby/version"
require "httparty"

module OngairRuby
  ONGAIR_URL = "http://#{ENV['subdomain']}.ongair.im/api/v1/base"

  class ClientV1
  	def initialize token
  		@token = token
  	end

  	def send_message(phone_number, message, thread=true)
  		HTTParty.post("#{ONGAIR_URL}/send", body: {token: @token, phone_number: phone_number, text: message, thread: thread })
  	end

  	def close_conversation(phone_number)
  		HTTParty.post("#{ONGAIR_URL}/conversations/#{phone_number}/close", body: {token: @token, phone_number: phone_number })
  	end
  end
end
