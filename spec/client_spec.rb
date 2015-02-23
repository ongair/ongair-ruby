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

describe OngairRuby::ClientV2 do

  before do
    stub_request(:post, "http://dev.ongair.im/api/v2/messages/send_message").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010208&text=Hi&thread=true",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {sent: true, id: 2935}.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v2/contacts").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&contact[name]=Nana&contact[phone_number]=254722010208",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {created: true, id: 1}.to_json, :headers => {})


    stub_request(:get, "http://dev.ongair.im/api/v2/contacts").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => [ { id: 1, phone_number: "254722123456", name: "XYZ" }, 
          { id: 2, phone_number: "254712345678", name: "LMN" } ].to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v2/groups").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&group[name]=Grp1&group[group_type]=Internal&group[jid]=grpjid",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {created: true, id: 1}.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v2/lists/1/add_contact").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&contact_id=1",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {success: true, contact: 1, distribution_list: 1}.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v2/lists/1/remove_contact").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&contact_id=1",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {success: true}.to_json, :headers => {})

    stub_request(:post, "http://dev.ongair.im/api/v2/lists/1/send_broadcast").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&message=hello",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {sent: true, id: 1}.to_json, :headers => {})

    stub_request(:get, "http://dev.ongair.im/api/v2/lists").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => [ { id: 1, name: "XYZ" }, 
          { id: 2, name: "LMN" } ].to_json, :headers => {})

    stub_request(:get, "http://dev.ongair.im/api/v2/lists/1/members").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => { members: [ { id: 1, phone_number: "254722123456", name: "XYZ" }, 
          { id: 2, phone_number: "254723123456", name: "LMN" } ] }.to_json, :headers => {})
  end

  context 'Send message' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.send_message("254722010208", "Hi")).to eql({sent:true, id:2935}.to_json)}
  end

  context 'Create contact' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.create_contact("Nana", "254722010208")).to eql({created: true, id: 1}.to_json)}
  end

  context 'Get contacts' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.contacts).to eql([ { id: 1, phone_number: "254722123456", name: "XYZ" }, 
      { id: 2, phone_number: "254712345678", name: "LMN" } ].to_json)}
  end

  context 'Create group' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.create_group("Grp1", "Internal", "grpjid")).to eql({created: true, id: 1}.to_json)}
  end

  context 'Add contact to list' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.add_list_member(1, 1)).to eql({success: true, contact: 1, distribution_list: 1}.to_json)}
  end

  context 'Remove contact from list' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.remove_list_member(1, 1)).to eql({success: true}.to_json)}
  end

  context 'Send broadcast to list' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.send_broadcast(1, "hello")).to eql({sent: true, id: 1}.to_json)}
  end

  context 'Get lists' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.lists).to eql([ { id: 1, name: "XYZ" }, 
      { id: 2 , name: "LMN"} ].to_json)}
  end

  context 'Get list members' do
    subject {
      OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.list_members(1)).to eql({ members: [ { id: 1, phone_number: "254722123456", name: "XYZ" }, 
          { id: 2, phone_number: "254723123456", name: "LMN" } ] }.to_json)}
  end
end