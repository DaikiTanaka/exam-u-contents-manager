require 'test_helper'

class UserAuthenticationTest < ActiveSupport::TestCase

  test '[正常系]認証成功' do
    User.create(username: 'user1', password: 'password')
    User.authenticate(
      username: 'user1',
      password: 'password',
      when_succeeded: ->(_) { assert true },
      when_failed: -> { assert false }
    )
  end

  test '[異常系]認証失敗 ユーザーが存在しない場合' do
    User.authenticate(
      username: 'user1',
      password: 'password',
      when_succeeded: ->(_) { assert false },
      when_failed: -> { assert true }
    )
  end

  test '[異常系]認証失敗 ユーザーIDが誤っている場合' do
    User.create(username: 'user1', password: 'password')
    User.authenticate(
      username: 'foo',
      password: 'password',
      when_succeeded: ->(_) { assert false },
      when_failed: -> { assert true }
    )
  end

  test '[異常系]認証失敗 パスワードが誤っている場合' do
    User.create(username: 'user1', password: 'password')
    User.authenticate(
      username: 'user1',
      password: 'foo',
      when_succeeded: ->(_) { assert false },
      when_failed: -> { assert true }
    )
  end
end
