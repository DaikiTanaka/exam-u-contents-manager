# MyTweetApp との連携におけるセッションの管理機能を提供します。
module MyTweetAppAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :my_tweet_app_integrated?
  end

  # セッションにアクセストークンが格納されていれば True を返します。
  #
  # @return [Boolean]
  def my_tweet_app_integrated?
    my_tweet_app_token.present?
  end

  # セッションに格納されているアクセストークンを返します。
  #
  # @return [String] セッションに格納されているアクセストークン
  def my_tweet_app_token
    session[:current_user_my_tweet_app_token]
  end

  # セッションにアクセストークンを格納します。
  #
  # @param [String] token アクセストークン
  # @return [不使用]
  def save_my_tweet_app_token(token)
    session[:current_user_my_tweet_app_token] = token
  end

  # セッションからアクセストークンを削除します。
  #
  # @return [不使用]
  def delete_my_tweet_app_token
    session[:current_user_my_tweet_app_token] = nil
  end

end
