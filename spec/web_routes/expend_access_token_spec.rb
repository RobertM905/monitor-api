# frozen_string_literal: true

describe 'expending an access token' do
  before do
    stub_const(
      'LocalAuthority::UseCase::ExpendAccessToken',
      double(new: expend_access_token_spy)
    )

    stub_const(
      'LocalAuthority::Gateway::InMemoryApiKeyGateway',
      double(new: nil)
    )
  end

  context 'with a valid access token' do
    let(:expend_access_token_spy) do
      spy(execute: { status: :success,
                     api_key: 'Doggos' })
    end

    context 'example one' do
      it 'responds with a 202' do
        post '/token/expend', { access_token: 'cats', project_id: '1' }.to_json
        expect(last_response.status).to eq(202)
      end

      it 'calls the expend token usecase' do
        post '/token/expend', { access_token: 'cats', project_id: '1' }.to_json
        expect(expend_access_token_spy).to have_received(:execute).with(access_token: 'cats', project_id: 1)
      end

      it 'returns the API key' do
        post '/token/expend', { access_token: 'cats', project_id: '1' }.to_json
        response = Common::DeepSymbolizeKeys.to_symbolized_hash(
          JSON.parse(last_response.body)
        )
        expect(response[:apiKey]).to eq('Doggos')
      end
    end

    context 'example two' do
      it 'responds with a 202' do
        post '/token/expend', { access_token: 'dogs', project_id: '10' }.to_json
        expect(last_response.status).to eq(202)
      end

      it 'calls the expend token usecase' do
        post '/token/expend', { access_token: 'dogs', project_id: '10' }.to_json
        expect(expend_access_token_spy).to have_received(:execute).with(access_token: 'dogs', project_id: 10)
      end
    end
  end

  context 'with an invalid access token' do
    let(:expend_access_token_spy) { spy(execute: { status: :failure }) }
    context 'example one' do
      it 'responds with a 401' do
        post '/token/expend', { access_token: 'cows', project_id: '1' }.to_json
        expect(last_response.status).to eq(401)
      end
    end

    context 'example two' do
      it 'responds with a 401' do
        post '/token/expend', { access_token: 'sheepex', project_id: '10' }.to_json
        expect(last_response.status).to eq(401)
      end
    end
  end
end
