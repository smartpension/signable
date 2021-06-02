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

Pre-recorded VCR cassettes are included in this repository so will be available locally. If no tests have been modified or new ones added, the test suite can be run with this command in the root directory, pre-recorded cassettes will be used and no requests will be sent to Signable API:

```ruby
bundle exec rspec
```

If tests are modified, delete cassettes for the tests in question and run test suite while providing a valid Signable API key, as requests must be sent to Signable to get responses for new cassettes (if in doubt whether you need to do this, just run the test suite and VCR will raise an error if it needs you to delete any cassettes).

Likewise run tests with valid Signable API key if new tests are added, as requests must be sent to Signable to get responses.

Run this command to run test suite with a Signable API key:

```ruby
SIGNABLE_API_KEY='valid_signable_api_key' bundle exec rspec
```

If you run the test suite with an invalid API key, if no tests have been modified or added, it will still work, as no requests will be made to Signable API. If you provide an invalid API key when requests do need to be made, you will get an error like this:

```ruby
Authentication failed. Either the API Key or password was blank.
```

If you run the test suite without specifying an API key, but also without having modified or added any tests, and you get that same error, it means one or more existing cassettes have passed our configured re-record interval of one month and VCR is attempting to make requests to Signable to get more recent responses to overwrite existing cassettes. Delete any cassettes recorded over a month ago (it's fine to delete them all if unsure) and run the test suite with a valid Signable API key so VCR can make the necessary requests.

To obtain a valid Signable API key:

1. Retrieve link and credentials for Signable test account from 1Password
2. Log in and navigate: Signable → Company Settings → Api & Webhooks
3. Create a new API key
4. Delete the API key when you are finished with it

## Contributing

1. Fork it ( http://github.com/<my-github-username>/signable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
