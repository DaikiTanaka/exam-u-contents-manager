require 'application_system_test_case'

class SessionsCreateTest < ApplicationSystemTestCase

  test '[正常系]正しいユーザーIDとパスワードを入力するとログインに成功し、写真一覧へリダイレクトされる' do
    User.create(username: 'user1', password: 'password')
    visit new_sessions_path
    fill_in 'forms_session_username', with: 'user1'
    fill_in 'forms_session_password', with: 'password'
    click_on 'commit'
    assert_text '写真一覧'
  end

  test '[異常系]ユーザーIDとパスワードを入力せずにログインを試みると、ログインできずエラーメッセージが表示される' do
    User.create(username: 'user1', password: 'password')
    visit new_sessions_path
    click_on 'commit'
    assert_text 'ユーザーIDを入力してください'
    assert_text 'パスワードを入力してください'
  end

  test '[異常系]誤ったユーザーIDとパスワードを入力してログインを試みると、ログインできずエラーメッセージが表示される' do
    User.create(username: 'user1', password: 'password')
    visit new_sessions_path
    fill_in 'forms_session_username', with: 'foo'
    fill_in 'forms_session_password', with: 'bar'
    click_on 'commit'
    assert_text 'ユーザーIDとパスワードが一致するユーザーが存在しません'
  end

  test '[異常系]正しいユーザーIDと、誤ったパスワードを入力してログインを試みると、ログインできずエラーメッセージが表示される' do
    User.create(username: 'user1', password: 'password')
    visit new_sessions_path
    fill_in 'forms_session_username', with: 'user1'
    fill_in 'forms_session_password', with: 'bar'
    click_on 'commit'
    assert_text 'ユーザーIDとパスワードが一致するユーザーが存在しません'
  end

end

class SessionsDeleteTest < ApplicationSystemTestCase

  test '[正常系]ログアウトボタンを押下するとログアウトできる' do
    create_user
    login
    visit root_path
    click_on 'link-to-sign-out'
    assert_current_path '/sessions/new'
    # 写真一覧へアクセスできない = ログアウトできたことを確認する
    visit photos_path
    assert_current_path '/sessions/new'
  end

end