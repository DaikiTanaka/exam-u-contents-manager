class SessionsController < ApplicationController

  skip_before_action :require_sign_in
  before_action :require_sign_out, except: [:destroy]

  include WholeErrorMessage
  include MyTweetAppAuthentication

  def new
    @form = ::Forms::Session.new
  end

  def create
    @form = ::Forms::Session.new(params.require(:forms_session).permit(:username, :password))
    if @form.valid?
      User.authenticate(
        username: @form.username,
        password: @form.password,
        when_succeeded: lambda { |user|
          sign_in user
          redirect_to :root
        },
        when_failed: lambda {
          add_whole_error_message 'ユーザーIDとパスワードが一致するユーザーが存在しません。'
          render action: :new
        }
      )
    else
      @form.errors.full_messages.each do |msg|
        add_whole_error_message msg
      end
      render action: :new
    end
  end

  def destroy
    sign_out
    delete_my_tweet_app_token
    redirect_to controller: :sessions, action: :new
  end

end
