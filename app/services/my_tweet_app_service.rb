require 'net/http'
require "json"

# 外部サービスの "MyTweetApp" へのアクセス機能を提供します。
module MyTweetAppService

  class << self

    # アクセストークンを取得します。
    #
    # @param [String] code OAuthの認可コード
    # @return [String] アクセストークン
    def get_token(code:)
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

    # ツイートを投稿します。
    #
    # @param [String] token アクセストークン
    # @param [String] text ツイートの文章
    # @param [String] image_url ツイートに添付する画像のURL
    # @return [Net::HTTPResponse] MyTweetAppからのレスポンス
    def tweet(token:, text:, image_url:)
      header = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      }
      uri = URI.parse(OAUTH_TWEET_URL)
      request = Net::HTTP::Post.new(uri.path, header)
      request.body = {
        text: text,
        url: image_url
      }.to_json
      Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        http.request(request)
      end
    end

    # 認可コードの取得用URLを取得します。
    #
    # @return [String] 認可コードの取得用URL
    def auth_request_url
      query = {
        client_id: OAUTH_CLIENT_ID,
        response_type: 'code',
        redirect_uri: OAUTH_REDIRECT_URI
      }.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{OAUTH_REQUEST_URL}?#{query}"
    end

  end
end
