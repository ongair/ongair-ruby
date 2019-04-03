require "ongair_ruby/version"
require "httparty"

module OngairRuby
  # ONGAIR_URL_V1 = "http://#{ENV['subdomain']}.ongair.im/api/v1/base"
  # ONGAIR_URL_V2 = "http://#{ENV['subdomain']}.ongair.im/api/v2"

  ONGAIR_URL = 'https://ongair.im'

  class ClientV1
  	def initialize token, base_url='https://ongair.im'
  		@token = token
      @base_url = base_url
  	end

  	def send_text_message(phone_number, message, thread=true, external_id=nil)
  		response = HTTParty.post("#{@base_url}/api/v1/base/send", body: {token: @token, phone_number: phone_number, text: message, thread: thread, external_id: external_id })
  	end

    def send_image(phone_number, image_url, name, caption="", content_type='image/jpg', thread=true, external_id=nil)
      response = HTTParty.post("#{@base_url}/api/v1/base/send_image", body: {token: @token, phone_number: phone_number, image: image_url, name: name, caption: caption, content_type: content_type, thread: thread, external_id: external_id })
    end

    def send_video(external_id, video_url, caption, thread=true)
      response = HTTParty.post("#{@base_url}/api/v1/base/send_video", body: {token: @token, external_id: external_id, video_url: video_url, caption: caption, thread: thread})
    end

    def send_audio(external_id, audio_url, caption, thread=true)
      response = HTTParty.post("#{@base_url}/api/v1/base/send_audio", body: {token: @token, external_id: external_id, audio_url: audio_url, caption: caption, thread: thread})
    end
  end

  class ClientV2
  	def initialize token, base_url='https://ongair.im'
  		@token = token
      @base_url = base_url
  	end

    def send_message(external_id, message, options=nil, thread=true)
      HTTParty.post("#{@base_url}/api/v1/base/send", body: {token: @token, external_id: external_id, text: message, thread: thread, options: options })
    end

    def send_image(external_id, image_url, content_type, caption=nil, options=nil, thread=true)
      HTTParty.post("#{@base_url}/api/v1/base/send_image", body: {token: @token, external_id: external_id, caption: caption, image: image_url, thread: thread, options: options })
    end

    ##
    # Send a chain of messages including options
    #
    # @example
    #
    # messages=[{ text: 'Hi'}, { text: 'Question?', options: ["1,2"]} ]
    def send_chain(external_id, messages, thread=true)
      HTTParty.post("#{@base_url}/api/v1/base/send_chain", body: {token: @token, external_id: external_id, messages: messages, thread: thread })
    end
  end
end
