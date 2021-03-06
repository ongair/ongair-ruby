require 'spec_helper'

describe OngairRuby::ClientV2 do

  context 'Sending of messages' do
    subject {
      OngairRuby::ClientV2.new("auth_token")
    }

    it 'Can send a message' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send")
        .with(
          body: "token=auth_token&external_id=1&text=Hello&thread=true&options=1%2C2"
        )
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_message('1', 'Hello', "1,2", true)
      result = JSON.parse(response.body)

      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'Can send an image' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_image")
        .with(
          body: "token=auth_token&external_id=1&caption=Hi&image=https%3A%2F%2Fimage.jpg&thread=true&options=1%2C2",
          headers: {
           'Accept'=>'*/*',
          })
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_image('1', 'https://image.jpg', 'image/jpeg', 'Hi', "1,2", true)
      result = JSON.parse(response.body)

      expect(stub).to have_been_made
      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'can send a chain with options' do

      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_chain")
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_chain('1', [{ :text => "Hi"}, { :text => "You good?", :options => ["Yes", "No" ]}])
      result = JSON.parse(response.body)

      expect(stub).to have_been_made
      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'can send a telephone number prompt' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_telephone_prompt")
        .with(
          body: "token=auth_token&external_id=1&text=Hi&thread=true"
        )
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)


      response = subject.send_telephone_prompt('1', "Hi")
      result = JSON.parse(response.body)

      expect(stub).to have_been_made
      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end

    it 'can send a location prompt' do
      stub = stub_request(:post, "#{OngairRuby::ONGAIR_URL}/api/v1/base/send_location_prompt")
        .with(
          body: "token=auth_token&external_id=1&text=Hi&thread=true"
        )
        .to_return(status: 200, :body => {sent: true, id: 1}.to_json)

      response = subject.send_location_prompt('1', "Hi")
      result = JSON.parse(response.body)

      expect(stub).to have_been_made
      expect(result['sent']).to be true
      expect(result['id']).to eql(1)
    end
  end
end
