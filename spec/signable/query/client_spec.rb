require "spec_helper"

describe Signable::Query::Client, :aggregate_failures do
  Signable.configure do |config|
    config.base_url = 'api.signable.co.uk'
    config.api_key  = ENV['SIGNABLE_API_KEY']
  end

  def client
    described_class.new
  end

  def create_envelope_params(template_fingerprint: nil, party_id: nil)
    template_info = client.all('templates', 0, 10).http_response['templates'].first
    template_fingerprint_param = template_fingerprint || template_info['template_fingerprint']
    party_id_param = party_id || template_info['template_parties'].first['party_id']

    double(form_data: {
      envelope_title: 'whatever',
      envelope_documents: [
        {
          document_title: 'title',
          document_template_fingerprint: template_fingerprint_param,
        }
      ],
      envelope_parties: [
        {
          party_name: 'something',
          party_email: 'something@gmail.com',
          party_id: party_id_param,
        }
      ]
    })
  end

  describe '#all' do
    context 'when requesting all envelopes' do
      it 'gets a response listing all envelopes', vcr: 'client/envelopes/all/success' do
        3.times { client.create('envelopes', create_envelope_params) }

        response = client.all('envelopes', 0, 10)

        expect(response).to be_instance_of(Signable::Query::Response)
        expect(response.ok?).to eq(true)
        expect(response.http_response['envelopes'].count).to eq(3)

        response.http_response['envelopes'].each do |envelope|
          client.cancel('envelopes', envelope['envelope_fingerprint'])
          client.delete('envelopes', envelope['envelope_fingerprint'])
        end
      end
    end
  end

  describe '#find' do
    context 'when requesting an envelope with a specific fingerprint' do
      context 'when envelope with provided fingerprint exists' do
        it 'gets a response containing information for that envelope', vcr: 'client/envelopes/find/success' do
          create_response = client.create('envelopes', create_envelope_params)

          response = client.find('envelopes', create_response.http_response['envelope_fingerprint'])

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(true)
          expect(response.http_response['envelope_fingerprint'])
            .to eq(create_response.http_response['envelope_fingerprint'])

          client.cancel('envelopes', create_response.http_response['envelope_fingerprint'])
          client.delete('envelopes', create_response.http_response['envelope_fingerprint'])
        end
      end

      context 'when envelope with provided fingerprint does not exist' do
        it 'returns message saying the envelope does not exist', vcr: 'client/envelopes/find/not_found' do
          response = client.find('envelopes', 'non_existent_fingerprint')

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.object["message"])
            .to eq('The envelope does not exist. Have you used the correct envelope fingerprint?')
        end
      end
    end
  end

  describe '#update' do
    context 'when sending request to update a contact of a specific ID' do
      context 'when contact with provided ID exists' do
        it 'gets a response containing the updated contact information', vcr: 'client/contacts/update/success' do
          create_info = double(form_data: {contact_name: 'One', contact_email: 'one@gmail.com'})
          contact = client.create('contacts', create_info)
          contact_id = contact.http_response['contact_id']

          update_info = double(form_data: {contact_name: 'Two', contact_email: 'two@gmail.com'})
          response = client.update('contacts', contact_id, update_info)

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(true)
          expect(response.http_response['contact_name']).to eq('Two')
          expect(response.http_response['contact_email']).to eq('two@gmail.com')

          client.delete('contacts', contact_id)
        end
      end

      context 'when contact with provided ID does not exist' do
        it 'returns message saying the contact does not exist', vcr: 'client/contacts/update/not_found'  do
          update_info = double(form_data: {contact_name: 'Two', contact_email: 'two@gmail.com'})
          response = client.update('contacts', 999_999_999_999, update_info)

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.object['message']).to eq('The contact does not exist. Have you used the correct contact ID?')
        end
      end
    end
  end

  describe '#create' do
    context 'when sending request to create an envelope' do
      context 'when existant template and party are provided' do
        it 'returns message confirming the envelope has been created', vcr: 'client/envelopes/create/success' do
          response = client.create('envelopes', create_envelope_params)

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(true)
          expect(response.http_response['envelope_title']).to eq('whatever')
          expect(response.http_response['message'])
            .to eq('Your envelope with title whatever will be processed and sent out.')

          client.cancel('envelopes', response.http_response['envelope_fingerprint'])
          client.delete('envelopes', response.http_response['envelope_fingerprint'])
        end
      end

      context 'when non-existant template is provided' do
        it 'returns message saying the template not exist', vcr: 'client/envelopes/create/not_found_template' do
          response = client.create('envelopes', create_envelope_params(template_fingerprint: 'invalid'))

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.http_response['message'])
            .to eq('The template does not exist. Have you used the correct template fingerprint?')
        end
      end

      context 'when non-existant party is provided' do
        it 'returns message saying the party_id is invalid', vcr: 'client/envelopes/create/not_found_party' do
          response = client.create('envelopes', create_envelope_params(party_id: 999_999_999_999))

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.http_response['message']).to eq(
            'The party_id you have provided isn\'t a valid party for the template fingerprint you have provided.'
          )
        end
      end
    end
  end

  describe '#delete' do
    context 'when sending a request to delete an envelope' do
      context 'when envelope with provided fingerprint exists' do
        it 'returns message confirming the envelope has been deleted', vcr: 'client/envelopes/delete/success' do
          create_response = client.create('envelopes', create_envelope_params)

          client.cancel('envelopes', create_response.http_response['envelope_fingerprint'])

          response = client.delete('envelopes', create_response.http_response['envelope_fingerprint'])

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(true)
          expect(response.http_response['message'])
            .to eq('The envelope has been deleted')
        end
      end

      context 'when envelope with provided fingerprint does not exist' do
        it 'returns message saying the envelope does not exist', vcr: 'client/envelopes/delete/not_found' do
          response = client.delete('envelopes', 'invalid')

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.http_response['message'])
            .to eq('The envelope does not exist. Have you used the correct envelope fingerprint?')
        end
      end

      context 'when envelope has not been cancelled so is still active' do
        it 'returns message saying envelope cannot be deleted because it is active', vcr: 'client/envelopes/delete/not_cancelled' do
          create_response = client.create('envelopes', create_envelope_params)

          response = client.delete('envelopes', create_response.http_response['envelope_fingerprint'])

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.http_response['message'])
            .to eq('The envelope you are trying to delete doesn\'t have the correct status. The envelope can\'t still be active.')

          client.cancel('envelopes', response.http_response['envelope_fingerprint'])
          client.delete('envelopes', response.http_response['envelope_fingerprint'])
        end
      end
    end
  end

  describe '#cancel' do
    context 'when sending a request to cancel an envelope' do
      context 'when envelope with provided fingerprint exists' do
        it 'returns message confirming the envelope has been cancelled', vcr: 'client/envelopes/cancel/success' do
          create_response = client.create('envelopes', create_envelope_params)

          response = client.cancel('envelopes', create_response.http_response['envelope_fingerprint'])

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(true)
          expect(response.http_response['message'])
            .to eq('The envelope has been cancelled')

          client.delete('envelopes', response.http_response['envelope_fingerprint'])
        end
      end

      context 'when envelope with provided fingerprint does not exist' do
        it 'returns message saying the envelope does not exist', vcr: 'client/envelopes/cancel/not_found' do
          response = client.cancel('envelopes', 'invalid')

          expect(response).to be_instance_of(Signable::Query::Response)
          expect(response.ok?).to eq(false)
          expect(response.http_response['message'])
            .to eq('The envelope does not exist. Have you used the correct envelope fingerprint?')
        end
      end
    end
  end

  describe '#remind' do
    context 'when envelope with provided fingerprint exists' do
      it 'gets a response confirming the reminder has been sent', vcr: 'client/envelopes/remind/success' do
        create_response = client.create('envelopes', create_envelope_params)

        response = client.remind('envelopes', create_response.http_response['envelope_fingerprint'])

        expect(response).to be_instance_of(Signable::Query::Response)
        expect(response.ok?).to eq(true)
        expect(response.object["message"]).to eq('The next signing party for this envelope has been reminded.')

        client.cancel('envelopes', create_response.http_response['envelope_fingerprint'])
        client.delete('envelopes', create_response.http_response['envelope_fingerprint'])
      end
    end

    context 'when envelope with provided fingerprint does not exist' do
      it 'returns message saying the envelope does not exist', vcr: 'client/envelopes/remind/not_found' do
        response = client.remind('envelopes', 'non_existent_fingerprint')

        expect(response).to be_instance_of(Signable::Query::Response)
        expect(response.ok?).to eq(false)
        expect(response.object["message"]).to eq(
          'The envelope does not exist. Have you used the correct envelope fingerprint?'
        )
      end
    end

    context 'when envelope with provided fingerprint exists but has been cancelled' do
      it 'returns message saying envelope does not have correct status', vcr: 'client/envelopes/remind/cancelled' do
        create_response = client.create('envelopes', create_envelope_params)
        client.cancel('envelopes', create_response.http_response['envelope_fingerprint'])

        response = client.remind('envelopes', create_response.http_response['envelope_fingerprint'])

        expect(response).to be_instance_of(Signable::Query::Response)
        expect(response.ok?).to eq(false)
        expect(response.object["message"]).to eq(
          "The envelope you are trying to remind doesn't have the correct status." +
          " The envelope can't be complete and must still be active."
        )

        client.delete('envelopes', create_response.http_response['envelope_fingerprint'])
      end
    end
  end
end
