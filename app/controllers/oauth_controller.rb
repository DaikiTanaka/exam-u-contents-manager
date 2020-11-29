class OauthController < ApplicationController

  include MyTweetAppAuthentication

  # システムテスト用です。
  # 直接外部へ visit できない現象が発生し、コントローラを介すことにしました。
  def app
    redirect_to OAUTH_APP_URL
  end

  def auth_request
    redirect_to MyTweetAppService.auth_request_url
  end

  def callback
    code = params.permit(:code).fetch(:code)
    save_my_tweet_app_token MyTweetAppService.get_token(
      code: code
    )
    redirect_to photos_path
  end

end
