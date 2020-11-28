module MyTweetAppAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :my_tweet_app_integrated?
  end

  def my_tweet_app_integrated?
    my_tweet_app_token.present?
  end

  def my_tweet_app_token
    session[:current_user_my_tweet_app_token]
  end

  def save_my_tweet_app_token(token)
    session[:current_user_my_tweet_app_token] = token
  end

  def delete_my_tweet_app_token
    session[:current_user_my_tweet_app_token] = nil
  end

end
