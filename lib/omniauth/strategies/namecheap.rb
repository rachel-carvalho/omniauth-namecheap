require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Namecheap < OmniAuth::Strategies::OAuth2
      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, site:          'https://www.sandbox.namecheap.com',
                              authorize_url: '/apps/sso/api/authorize',
                              token_url:     '/apps/sso/api/token',
                              me_url:        '/apps/sso/api/resource/user'

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['sub'] }

      info { deep_symbolize(raw_info) }

      def raw_info
        @raw_info ||= JSON.parse(access_token.get(client.options[:me_url]).body)
      end
    end
  end
end