require 'test_helper'

class SessionFormTest < ActiveSupport::TestCase

  test '[正常系]認証可能' do
    form = Forms::Session.new(username: 'user1', password: 'password')
    assert form.valid?
  end

  test '[正常系]認証不可 ユーザーIDが未入力' do
    form = Forms::Session.new(username: '', password: 'password')
    assert_not form.valid?
    assert_not_nil form.errors[:username]
  end

  test '[正常系]認証不可 パスワードが未入力' do
    form = Forms::Session.new(username: 'user1', password: '')
    assert_not form.valid?
    assert_not_nil form.errors[:password]
  end
end
