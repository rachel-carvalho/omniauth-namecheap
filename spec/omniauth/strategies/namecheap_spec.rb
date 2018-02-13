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
end
