require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test '[正常系]パスワードを暗号化して生成します' do
    user = User.new(username: 'user1', password: 'password')
    assert_not_nil user.encrypted_password
    assert_not_equal 'password', user.encrypted_password
  end

  test '[正常系]パスワードを暗号化して保存します' do
    User.create(username: 'user1', password: 'password')
    user = User.last
    assert_not_nil user.encrypted_password
    assert_not_equal 'password', user.encrypted_password
  end
end
