class MyTweetAppController < ApplicationController

  include MyTweetAppAuthentication

  before_action :require_integration, only: [:tweet]

  def tweet
    res = MyTweetAppService.tweet(
      token: my_tweet_app_token,
      text: params.fetch(:text),
      image_url: params.fetch(:url)
    )
    message = res.code == '201' ? 'ツイートしました。' : 'ツイートできませんでした。'
    redirect_to photos_url, notice: message
  end

  private

  def require_integration
    redirect_to :back unless my_tweet_app_integrated?
  end

end
