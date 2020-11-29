# ユーザーのログイン状態の管理機能を提供します。
module UserAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_sign_in
    helper_method :signed_in?
  end

  protected

  # ログインします。
  #
  # * セッションにユーザーのIDを格納します。
  #
  # @param [User < ActiveRecord] user ユーザーモデル
  # @return [不使用]
  def sign_in(user)
    session[:current_user_id] = user.id
  end

  # ログイン中のユーザーを取得します。
  #
  # @return [User < ActiveRecord] ユーザーモデル
  def current_user
    @_current_user ||= User.where(id: session[:current_user_id]).first
  end

  # ログイン中の場合 true を返します。
  #
  # @return [Boolean]
  def signed_in?
    current_user != nil
  end

  # ログアウトします。
  #
  # * セッションからログインユーザーのIDを削除します。
  #
  # @return [不使用]
  def sign_out
    session[:current_user_id] = nil
  end

  # ログイン中でない場合、ログイン画面へリダイレクトします。
  #
  # * Controller の before_action に設定してください。
  #
  # @return [不使用]
  def require_sign_in
    redirect_to controller: :sessions, action: :new unless signed_in?
  end

  # ログイン中の場合、トップページへリダイレクトします。
  #
  # * Controller の before_action に設定してください。
  #
  # @return [不使用]
  def require_sign_out
    redirect_to :root if signed_in?
  end
end
