class OauthController < ApplicationController

  include MyTweetAppAuthentication

  # システムテスト用です。
  # 直接外部へ visit できない現象が発生し、コントローラを介すことにしました。
  def app
    redirect_to OAUTH_APP_URL
  end

  def auth_request
    query = {
        client_id: OAUTH_CLIENT_ID,
        response_type: 'code',
        redirect_uri: oauth_redirect_uri
    }.map { |k, v| "#{k}=#{v}" }.join('&')
    redirect_to "#{OAUTH_REQUEST_URL}?#{query}"
  end

  def callback
    code = params.permit(:code).fetch(:code)
    save_my_tweet_app_token MyTweetAppService.get_token(
      code: code,
      redirect_uri: oauth_redirect_uri
    )
    redirect_to photos_path
  end

  private

  def oauth_redirect_uri
    OAUTH_REDIRECT_URI
  end

end
