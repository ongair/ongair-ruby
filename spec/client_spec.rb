require 'spec_helper'

describe OngairRuby::ClientV1 do

  before do
    stub_request(:post, "http://dev.ongair.im/api/v1/base/send").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010208&text=Hi&thread=true",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {sent: true, id: 2935}.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v1/base/conversations/254722010208/close").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010208",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => { id: 1, status: "Closed" }.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v1/base/conversations/254722010201/close").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010201",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => { message: "No open conversations for 254722010201" }.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v1/base/conversations/254722010200/close").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010200",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => { message: "No contact exists for 254722010200" }.to_json, :headers => {})
  end

  context 'Send message' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.send_message("254722010208", "Hi")).to eql({sent:true, id:2935}.to_json)}
  end

  context 'Close a conversation' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.close_conversation("254722010208")).to eql({ id: 1, status: "Closed" }.to_json)}
  end

  context 'Try to close a conversation when there is none open for contact' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.close_conversation("254722010201")).to eql({ message: "No open conversations for 254722010201" }.to_json)}
  end

  context 'Try to close a conversation when contact does not exist' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.close_conversation("254722010200")).to eql({ message: "No contact exists for 254722010200" }.to_json)}
  end
end