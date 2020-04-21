# frozen_string_literal: true

module Auth
  module Oauth
    class GithubCallback < WebBouncer::OauthCallback
      def call(oauth_response)
        data = account_data(oauth_response)

        account = account_repo.find_by_github(data[:github])
        account ||= account_repo.create(data)

        Success(account)
      end

      private

      DEFAUTL_EMAL = 'anonymous@rubyjobs.dev'

      def account_repo
        @account_repo ||= AccountRepository.new
      end

      def account_data(data)
        {
          github: data['info']['nickname'],
          email: data['info']['email'] || DEFAUTL_EMAL,
          name: data['info']['name'],
          avatar_url: data['info']['image']
        }
      end
    end
  end
end
