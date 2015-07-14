# OngairRuby

Ruby gem for using Ongair to to interact with WhatsApp; send messages, send media, add contacts, create groups, create lists, send broadcasts and many more.

## Installation

Add this line to your application's Gemfile:

    gem 'ongair_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ongair_ruby
    
Get the Ongair API key by signing up here: http://app.ongair.im

## Usage

        client = OngairRuby::ClientV2.new("YOUR_ONGAIR_API_KEY")
        # Add a contact
        client.create_contact("Name of contact", "254711223344")
        
        # Send a message
        client.send_message("254711223344", "Hello")

        # Send an image
        client.send_image("254722123456", "http://domain.com/image.jpg")
        
## Coming soon
        # List of contacts
        client.contacts
        
        # Create a WhatsApp group
        client.create_group("group_name", "group_type", "group_jid")
        
        # List of groups
        client.groups
        
        # Create a distribution list
        client.create_list("list_name", "list_description")
        
        # List of distribution lists
        client.lists
        
        # Add contact to a distribution list
        client.add_list_member(list_id, contact_id)
        
        # List of distribution list members
        client.list_members(list_id)
        
        # remove contact from a distribution list
        client.remove_list_member(list_id, contact_id)
        
        # send broadcasts to a distribution list
        client.send_broadcast(list_id, "Hello everyone")

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ongair_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
