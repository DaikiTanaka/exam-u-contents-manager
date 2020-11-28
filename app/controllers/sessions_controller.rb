class SessionsController < ApplicationController

  skip_before_action :require_sign_in
  before_action :require_sign_out, except: [:destroy]

  include WholeErrorMessage

  def new
    @form = ::Forms::Session.new
  end

  def create
    @form = ::Forms::Session.new(params.require(:forms_session).permit(:username, :password))
    if @form.valid?
      if (user = authenticate(@form.username, @form.password)).present?
        sign_in user
        redirect_to :root and return
      else
        add_whole_error_message 'ユーザーIDとパスワードが一致するユーザーが存在しません。'
      end
    else
      @form.errors.full_messages.each do |msg|
        add_whole_error_message msg
      end
    end
    render action: :new
  end

  def destroy
    sign_out
    redirect_to controller: :sessions, action: :new
  end

end
