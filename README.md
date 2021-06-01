# Signable

The signable client provides a simple Ruby interface to the Signable API.

## Installation

Add this line to your application's Gemfile:

    gem 'signable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install signable

## Usage

### Configuration

```ruby
Signable.configure do |config|
  config.base_url = ENV.fetch('SIGNABLE_BASE_URL')
  config.api_key  = ENV.fetch('SIGNABLE_API_KEY')
end
```

### Retrieve a template

```ruby
Signable::Template.find 'fingerprint'
```

### Build a document

```ruby
Signable::Document.new(template_fingerprint: fingerprint, title: title)
```

A document may also contain merge_fields (see signable documentation)

### Build a party

```ruby
Signable::Party.new(id: id, name: 'name', email: 'email')
```

Party id can be retrieved from the template

### Create an envelope

```ruby
envelope = Signable::Envelope.new title: 'title', redirect_url: 'https://www.autoenrolment.co.uk'
envelope.documents = documents
envelope.parties = parties

envelope.save
```

## Testing

Test suite is RSpec and uses VCR to test API calls.
Run this command from the root directory to run all tests:

```ruby
SIGNABLE_API_KEY='qwertyuiop' bundle exec rspec
```

If re-recording any VCR cassettes, you will need to specify a valid Signable API key.

To obtain a valid Signable API key:

1. Retrieve link and credentials for Signable test account from 1Password
2. Log in and navigate: Signable → Company Profile → Api & Webhooks
3. Create a new API key
4. Delete the API key when you are finished with it

## Contributing

1. Fork it ( http://github.com/<my-github-username>/signable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
