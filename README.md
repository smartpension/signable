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

The VCR cassettes are included in this repository so you can run the specs without hitting the Signable API like so:

```ruby
bundle exec rspec
```

If you need to re-record the interactions between the Ruby code and the Signable API, you can specify an API key for the tests to use like so:

```ruby
SIGNABLE_API_KEY='valid_signable_api_key' bundle exec rspec
```

If you have an invalid or missing API, you will see an error like the following:

```ruby
Authentication failed. Either the API Key or password was blank.
```

NOTE:
* The VCR recordings have an expiry time, so you may be forced to re-record them even if you have made no changes
* The test suite is destructive so please only use a test Signable account. The account requires one Template resource in order for the test suite to run.

To obtain a valid Signable API key, log into your Signable account and navigate to Company Settings → Api & Webhooks and click "Add API Key" to generate a key. We recommend you delete the key when finished with it.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/signable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
