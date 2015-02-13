require "ongair_ruby/version"
require "httparty"

module OngairRuby
  module_function

  def send_message(phone_number, message, thread=true)
  	HTTParty.post("#{ENV['ONGAIR_URL']}/send", body: {token: ENV['ONGAIR_API_TOKKEN'], phone_number: phone_number, text: message, thread: thread })
  end

  def close_conversation(phone_number)
  	HTTParty.post("#{ENV['ONGAIR_URL']}/conversations/#{phone_number}/close", body: {token: ENV['ONGAIR_API_TOKKEN'], phone_number: phone_number })
  end
end
