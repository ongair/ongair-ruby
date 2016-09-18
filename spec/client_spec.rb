require 'spec_helper'

describe OngairRuby::ClientV1 do

  before do
    # stub_request(:post, "http://dev.ongair.im/api/v1/base/send").
    #      with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010208&text=Hi&thread=true",
    #           :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    #      to_return(:status => 200, :body => {sent: true, id: 2935}.to_json, :headers => {})

    # stub_request(:post, "http://dev.ongair.im/api/v1/base/conversations/254722010208/close").
    #      with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010208",
    #           :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    #      to_return(:status => 200, :body => { id: 1, status: "Closed" }.to_json, :headers => {})

    # stub_request(:post, "http://dev.ongair.im/api/v1/base/conversations/254722010201/close").
    #      with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010201",
    #           :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    #      to_return(:status => 200, :body => { message: "No open conversations for 254722010201" }.to_json, :headers => {})

    # stub_request(:post, "http://dev.ongair.im/api/v1/base/conversations/254722010200/close").
    #      with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010200",
    #           :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    #      to_return(:status => 200, :body => { message: "No contact exists for 254722010200" }.to_json, :headers => {})
    # request = stub_request(:post, 'https://app.ongair.im/api/v1/base/send')
    #     .with(body: hash_including({ phone_number: '254722010208', text: 'Hi' }), headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'} )
    #     .to_return(status: 200, body: { sent: true, id:2935 }.to_json )

    ruby_headers = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}

    stub_request(:post, "https://ongair.im/api/v1/base/send").
      with(:body => hash_including({ phone_number: '254722010208', text: 'Hi' }), headers: ruby_headers ).
        to_return(:status => 200, body: { sent: true, id:2935 }.to_json, :headers => {})

    stub_request(:post, "https://ongair.im/api/v1/base/send_image").
      with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=2547222010208&image=http%3A%2F%2Fgoogle.com%2Fimage.jpg&name=image.jpg&caption=Caption&content_type=image%2Fjpg&thread=true&external_id=", headers: ruby_headers ).
      to_return(:status => 200, body: { sent: true, id:2940 }.to_json, :headers => {})

    stub_request(:post, "https://ongair.im/api/v1/base/send").
      with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=&text=Hi&thread=&external_id=1234567890", headers: ruby_headers).
         to_return(:status => 200, :body => { sent: true, id:3000 }.to_json, :headers => {})

    stub_request(:post, "https://ongair.im/api/v1/base/send_video").
         with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&external_id=1234567890&video=https%3A%2F%2Fvideo.mp4&caption=&thread=true").
         to_return(:status => 200, :body => { sent: true, id: 3001 }.to_json, :headers => {})

    stub_request(:post, "https://ongair.im/api/v1/base/send_audio").
      with(body: "token=7c96876b64f3bf9b46bb39b89a9cwo20&external_id=1234567890&audio=https%3A%2F%2Faudio.mp3&caption=&thread=true").
      to_return(:status => 200, body: {sent: true, id: 3002}.to_json, headers: {})

  end

  context 'Send message' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }

    it { expect(subject.send_text_message("254722010208", "Hi")).to eql({sent:true, id:2935}.to_json) }

    it { expect(subject.send_image('2547222010208', 'http://google.com/image.jpg', 'image.jpg', "Caption")).to eql({sent: true, id: 2940}.to_json ) }
  end

  context 'send message with external id' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.send_text_message("", "Hi", nil, "1234567890")).to eql({sent:true, id:3000}.to_json) }

  end

  context 'Send video' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.send_video("1234567890", "https://video.mp4", "")).to eql({sent:true, id:3001}.to_json) }
  end

  context 'Send audio' do
    subject {
      OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
    }
    it { expect(subject.send_audio("1234567890", "https://audio.mp3", "")).to eql({sent:true, id:3002}.to_json) }
  end


  # context 'Close a conversation' do
  #   subject {
  #     OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.close_conversation("254722010208")).to eql({ id: 1, status: "Closed" }.to_json)}
  # end

  # context 'Try to close a conversation when there is none open for contact' do
  #   subject {
  #     OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.close_conversation("254722010201")).to eql({ message: "No open conversations for 254722010201" }.to_json)}
  # end

  # context 'Try to close a conversation when contact does not exist' do
  #   subject {
  #     OngairRuby::ClientV1.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.close_conversation("254722010200")).to eql({ message: "No contact exists for 254722010200" }.to_json)}
  # end
end

# describe OngairRuby::ClientV2 do

  # before do
  #   stub_request(:post, "http://dev.ongair.im/api/v2/messages/send_message").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&phone_number=254722010208&text=Hi&thread=true",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {sent: true, id: 2935}.to_json, :headers => {})

  #   stub_request(:post, "http://dev.ongair.im/api/v2/contacts").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&contact[name]=Nana&contact[phone_number]=254722010208",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {created: true, id: 1}.to_json, :headers => {})


  #   stub_request(:get, "http://dev.ongair.im/api/v2/contacts").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => [ { id: 1, phone_number: "254722123456", name: "XYZ" },
  #         { id: 2, phone_number: "254712345678", name: "LMN" } ].to_json, :headers => {})

  #   stub_request(:post, "http://dev.ongair.im/api/v2/groups").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&group[name]=Grp1&group[group_type]=Internal&group[jid]=grpjid",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {created: true, id: 1}.to_json, :headers => {})

  #   stub_request(:get, "http://dev.ongair.im/api/v2/groups").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => [ { id: 285, name: "#ShikaMita", contacts: [ { id: 5829 }, { id: 5833 } ] },
  #         { id: 285, name: "Group A", contacts: [ { id: 392 }, { id: 478 } ] } ].to_json, :headers => {})

  #   stub_request(:post, "http://dev.ongair.im/api/v2/lists").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&name=list_name&description=list_description",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {success: true, id: 1}.to_json, :headers => {})

  #   stub_request(:post, "http://dev.ongair.im/api/v2/lists/1/add_contact").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&contact_id=1",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {success: true, contact: 1, distribution_list: 1}.to_json, :headers => {})

  #   stub_request(:post, "http://dev.ongair.im/api/v2/lists/1/remove_contact").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&contact_id=1",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {success: true}.to_json, :headers => {})

  #   stub_request(:post, "http://dev.ongair.im/api/v2/lists/1/send_broadcast").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20&message=hello",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => {sent: true, id: 1}.to_json, :headers => {})

  #   stub_request(:get, "http://dev.ongair.im/api/v2/lists").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => [ { id: 1, name: "XYZ" },
  #         { id: 2, name: "LMN" } ].to_json, :headers => {})

  #   stub_request(:get, "http://dev.ongair.im/api/v2/lists/1/members").
  #        with(:body => "token=7c96876b64f3bf9b46bb39b89a9cwo20",
  #             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => { members: [ { id: 1, phone_number: "254722123456", name: "XYZ" },
  #         { id: 2, phone_number: "254723123456", name: "LMN" } ] }.to_json, :headers => {})
  # end

  # context 'Send message' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.send_message("254722010208", "Hi")).to eql({sent:true, id:2935}.to_json)}
  # end

  # context 'Create contact' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.create_contact("Nana", "254722010208")).to eql({created: true, id: 1}.to_json)}
  # end

  # context 'Get contacts' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.contacts).to eql([ { id: 1, phone_number: "254722123456", name: "XYZ" },
  #     { id: 2, phone_number: "254712345678", name: "LMN" } ].to_json)}
  # end

  # context 'Create group' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.create_group("Grp1", "Internal", "grpjid")).to eql({created: true, id: 1}.to_json)}
  # end

  # context 'List of groups' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.groups).to eql([ { id: 285, name: "#ShikaMita", contacts: [ { id: 5829 }, { id: 5833 } ] },
  #         { id: 285, name: "Group A", contacts: [ { id: 392 }, { id: 478 } ] } ].to_json)}
  # end

  # context 'Create a list' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.create_list("list_name", "list_description")).to eql({success: true, id: 1}.to_json)}
  # end

  # context 'Add contact to list' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.add_list_member(1, 1)).to eql({success: true, contact: 1, distribution_list: 1}.to_json)}
  # end

  # context 'Remove contact from list' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.remove_list_member(1, 1)).to eql({success: true}.to_json)}
  # end

  # context 'Send broadcast to list' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.send_broadcast(1, "hello")).to eql({sent: true, id: 1}.to_json)}
  # end

  # context 'Get lists' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.lists).to eql([ { id: 1, name: "XYZ" },
  #     { id: 2 , name: "LMN"} ].to_json)}
  # end

  # context 'Get list members' do
  #   subject {
  #     OngairRuby::ClientV2.new("7c96876b64f3bf9b46bb39b89a9cwo20")
  #   }
  #   it { expect(subject.list_members(1)).to eql({ members: [ { id: 1, phone_number: "254722123456", name: "XYZ" },
  #         { id: 2, phone_number: "254723123456", name: "LMN" } ] }.to_json)}
  # end
# end
