module UserAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_sign_in
    helper_method :signed_in?
  end

  protected

  def sign_in(user)
    session[:current_user_id] = user.id
  end

  def current_user
    @_current_user ||= User.where(id: session[:current_user_id]).first
  end

  def signed_in?
    current_user != nil
  end

  def sign_out
    session[:current_user_id] = nil
  end

  def require_sign_in
    redirect_to controller: :sessions, action: :new unless signed_in?
  end

  def require_sign_out
    redirect_to :root if signed_in?
  end
end
