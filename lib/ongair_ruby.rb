require "ongair_ruby/version"
require "httparty"

module OngairRuby
  ONGAIR_URL_V1 = "http://#{ENV['subdomain']}.ongair.im/api/v1/base"
  ONGAIR_URL_V2 = "http://#{ENV['subdomain']}.ongair.im/api/v2"

  class ClientV1
  	def initialize token
  		@token = token
  	end

  	def send_message(phone_number, message, thread=true)
  		HTTParty.post("#{ONGAIR_URL_V1}/send", body: {token: @token, phone_number: phone_number, text: message, thread: thread })
  	end

  	def close_conversation(phone_number)
  		HTTParty.post("#{ONGAIR_URL_V1}/conversations/#{phone_number}/close", body: {token: @token, phone_number: phone_number })
  	end

  	def create_contact name, phone_number
  		HTTParty.post("#{ONGAIR_URL_V1}/create_contact", body: {token: @token, phone_number: phone_number, name: name})
  	end

  	# def create_group name
  	# 	HTTParty.post("#{ONGAIR_URL_V1}/create_group", body: {token: @token, name: name})
  	# end

  	def add_group_member group_id, phone_number
  		HTTParty.post("#{ONGAIR_URL_V1}/groups/#{group_id}/add_participant", body: {token: @token, phone_number: phone_number})
  	end

  	def remove_group_member group_id, phone_number
  		HTTParty.post("#{ONGAIR_URL_V1}/groups/#{group_id}/remove_participant", body: {token: @token, phone_number: phone_number})
  	end

  	def send_group_message phone_number, text
  		HTTParty.post("#{ONGAIR_URL_V1}/groups/#{group_id}/send_message", body: {token: @token, phone_number: phone_number, text: text})
  	end
  end

  class ClientV2
  	def initialize token
  		@token = token
  	end

  	def send_message(phone_number, message, thread=true)
  		HTTParty.post("#{ONGAIR_URL_V2}/messages/send_message", body: {token: @token, phone_number: phone_number, text: message, thread: thread })
  	end

  	# def close_conversation(phone_number)
  	# 	HTTParty.post("#{ONGAIR_URL_V2}/conversations/#{phone_number}/close", body: {token: @token, phone_number: phone_number })
  	# end

  	def create_contact name, phone_number
  		HTTParty.post("#{ONGAIR_URL_V2}/contacts", body: {token: @token, contact: {name: name, phone_number: phone_number}})
  	end

  	def contacts
  		HTTParty.get("#{ONGAIR_URL_V2}/contacts", body: {token: @token})
  	end

  	def create_group name, group_type, jid
  		HTTParty.post("#{ONGAIR_URL_V2}/groups", body: {token: @token, group: {name: name, group_type: group_type, jid: jid}})
  	end

  	def groups
  		HTTParty.get("#{ONGAIR_URL_V2}/groups", body: {token: @token})
  	end

  	# def add_group_member group_id, phone_number
  	# 	HTTParty.post("#{ONGAIR_URL_V2}/groups/#{group_id}/add_participant", body: {token: @token, phone_number: phone_number})
  	# end

  	# def remove_group_member group_id, phone_number
  	# 	HTTParty.post("#{ONGAIR_URL_V2}/groups/#{group_id}/remove_participant", body: {token: @token, phone_number: phone_number})
  	# end

  	# def send_group_message phone_number, text
  	# 	HTTParty.post("#{ONGAIR_URL_V2}/groups/#{group_id}/send_message", body: {token: @token, phone_number: phone_number, text: text})
  	# end

  	def add_list_member list_id, contact_id
  		HTTParty.post("#{ONGAIR_URL_V2}/lists/#{list_id}/add_contact", body: {token: @token, contact_id: contact_id})
  	end

  	def remove_list_member list_id, contact_id
  		HTTParty.post("#{ONGAIR_URL_V2}/lists/#{list_id}/remove_contact", body: {token: @token, phone_number: phone_number})
  	end

  	def send_broadcast list_id, message
  		HTTParty.post("#{ONGAIR_URL_V2}/lists/#{list_id}/send_broadcast", body: {token: @token, message: message})
  	end

  	def lists
  		HTTParty.get("#{ONGAIR_URL_V2}/lists", body: {token: @token})
  	end

  	def list_members list_id
  		HTTParty.get("#{ONGAIR_URL_V2}/lists/#{list_id}/members", body: {token: @token})
  	end
  end
end
