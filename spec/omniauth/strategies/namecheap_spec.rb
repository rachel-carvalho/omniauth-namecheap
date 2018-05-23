require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Namecheap do
  let(:response) { double(:response, body: File.read('spec/fixtures/user_info.json')) }
  let(:env)      { { "rack.session" => {} } }
  let(:instance) { described_class.new(nil) }

  subject { instance }

  before do
    instance.instance_variable_set :@env, env
    allow(instance).to receive(:access_token) { double(:access_token, get: response, token: 'tolkien') }
  end

  it { is_expected.to be_an OmniAuth::Strategies::OAuth2 }

  its(:name) { is_expected.to eq 'namecheap' }

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

    its(:site) { is_expected.to eq 'https://www.namecheap.com' }

    its(:options) { is_expected.to include authorize_url: '/apps/sso/api/authorize'     }
    its(:options) { is_expected.to include token_url:     '/apps/sso/api/token'         }
    its(:options) { is_expected.to include me_url:        '/apps/sso/api/resource/user' }
  end

  describe '#request_phase' do
    let(:callback_url) { 'https://lalala.com/auth/namecheap/callback?qs=huhu' }

    subject { instance.request_phase }

    before do
      allow(instance).to receive(:callback_url) { callback_url }
    end

    it 'saves callback url' do
      expect { subject }.to change { env['rack.session'][:namecheap_omnniauth_callback_url] }.to callback_url
    end

    it 'redirects' do
      expect(instance).to receive(:redirect).with %r{https://www.namecheap.com/apps/sso/api/authorize}
      subject
    end
  end

  describe '#build_access_token' do
    let(:token) { double(:token) }
    let(:saved_callback_url) { 'https://reddit.com/r/hmmm?other=thing' }

    subject { instance.build_access_token }

    before do
      allow(instance.request).to receive(:params) { { 'code' => 'lalala' } }
      allow(instance).to receive(:callback_url) { 'https://reddit.com/r/hmmm?this=query&other=thing' }
      env['rack.session'][:namecheap_omnniauth_callback_url] = saved_callback_url
      allow(instance).to receive_message_chain(:client, :auth_code, :get_token) { token }
    end

    it 'gets token with the code and redirect uri' do
      expect(instance).to receive_message_chain(:client, :auth_code, :get_token).with('lalala', { redirect_uri: saved_callback_url }, {})
      expect(subject).to eq token
    end
  end
end
