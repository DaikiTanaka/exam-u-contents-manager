require 'net/http'
require "json"

module MyTweetAppService

  def self.get_token(code)
    payloads = {
        code: code,
        client_id: OAUTH_CLIENT_ID,
        client_secret: OAUTH_CLIENT_SECRET,
        redirect_uri: OAUTH_REDIRECT_URI,
        grant_type: 'authorization_code'
    }
    uri = URI.parse(OAUTH_TOKEN_REQUEST_URL)
    response = Net::HTTP.post_form(uri, payloads)
    JSON.parse(response.body)['access_token']
  end

end