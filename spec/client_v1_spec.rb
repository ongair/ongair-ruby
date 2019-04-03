require 'spec_helper'

describe OngairRuby::ClientV1 do

  context 'Sending of messages' do
    subject {
      OngairRuby::ClientV1.new("auth_token")
    }

    it 'can send text messages' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send")
        .with(body: "token=auth_token&phone_number=1&text=Hi&thread=true&external_id=1")
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_text_message('1', 'Hi', true, '1')
      result = JSON.parse(response.body)

      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'can send images' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_image")
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_image('1', 'https://google.com/1.jpg', '1.jpg', 'Testing', 'image/jpg', true, '1')
      result = JSON.parse(response.body)

      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'can send video' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_video")
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_video('1', 'https://google.com/1.avi', 'Testing',true)
      result = JSON.parse(response.body)

      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'can send audio' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_audio")
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_audio('1', 'https://google.com/1.avi', 'Testing',true)
      result = JSON.parse(response.body)

      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end
  end
end
