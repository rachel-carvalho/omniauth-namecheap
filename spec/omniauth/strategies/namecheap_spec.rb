require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Namecheap do
  let(:response) { double(:response, body: File.read('spec/fixtures/user_info.json')) }

  subject { described_class.new(nil) }

  before do
    allow(subject).to receive(:access_token) { double(:access_token, get: response, token: 'tolkien') }
  end

  it { is_expected.to be_an OmniAuth::Strategies::OAuth2 }

  its(:raw_info) { is_expected.to eq JSON.parse(response.body) }

  its(:uid) { is_expected.to eq '666' }

  its(:info) { is_expected.to have_key :sub         }
  its(:info) { is_expected.to have_key :nickname    }
  its(:info) { is_expected.to have_key :name        }
  its(:info) { is_expected.to have_key :given_name  }
  its(:info) { is_expected.to have_key :family_name }
  its(:info) { is_expected.to have_key :email       }

  its(:extra) { is_expected.to eq({}) }

  describe '#client' do
    subject { described_class.new(nil).client }

    its(:site) { is_expected.to eq 'https://www.sandbox.namecheap.com' }

    its(:options) { is_expected.to include authorize_url: '/apps/sso/api/authorize'     }
    its(:options) { is_expected.to include token_url:     '/apps/sso/api/token'         }
    its(:options) { is_expected.to include me_url:        '/apps/sso/api/resource/user' }
  end

  describe '#build_access_token' do
    let(:token) { double(:token) }

    before do
      allow(subject.request).to receive(:params) { { 'code' => 'lalala' } }
      allow(subject).to receive(:query_string) { '?this=query' }
      allow(subject).to receive(:callback_url) { 'https://reddit.com/r/hmmm?this=query' }
    end

    it 'gets token with the code and redirect uri' do
      expect(subject).to receive_message_chain(:client, :auth_code, :get_token).with('lalala', { redirect_uri: 'https://reddit.com/r/hmmm' }, {}) { token }
      expect(subject.build_access_token).to eq token
    end
  end
end
