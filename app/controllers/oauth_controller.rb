class OauthController < ApplicationController

  # システムテスト用です。
  # 直接外部へ visit できない現象が発生し、コントローラを介すことにしました。
  def app
    redirect_to OAUTH_APP_URL
  end

  def auth_request
    query = {
        client_id: OAUTH_CLIENT_ID,
        response_type: 'code',
        redirect_uri: OAUTH_REDIRECT_URI
    }.map { |k, v| "#{k}=#{v}" }.join('&')
    redirect_to "#{OAUTH_REQUEST_URL}?#{query}"
  end

end
