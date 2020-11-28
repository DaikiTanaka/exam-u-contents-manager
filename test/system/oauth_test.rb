require 'application_system_test_case'

class OAuthAuthRequestTest < ApplicationSystemTestCase

  test '[正常系]MyTweetApp連携ボタンを押下すると連携承認画面が表示される' do
    create_user
    login
    # 事前にMyTweetAppで認証を済ませておく
    visit oauth_app_path
    fill_in 'sessions_new_form_uid', with: OAUTH_DEMO_USER_ID
    fill_in 'sessions_new_form_password', with: OAUTH_DEMO_USER_PASSWORD
    click_on 'commit'
    # 本アプリに戻り、MyTweetApp連携ボタンを押下する
    visit photos_path
    click_link 'link-to-oauth-request'
  end

end