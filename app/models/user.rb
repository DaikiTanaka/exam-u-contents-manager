class User < ApplicationRecord
  include PasswordEncryption

  has_many :photos

  scope :authenticated, lambda { |username, password|
    where(username: username).where(encrypted_password: PasswordEncryption.encrypt(password))
  }

  # 平文のログイン用パスワードをセットします。
  #
  # * ログイン用パスワードは暗号化され、属性 encrypted_password にセットされます。
  #
  # @param [String] new_password ログイン用パスワード(平文)
  # @return [不使用]
  def password=(new_password)
    self.encrypted_password = encrypt(new_password)
  end

  # ユーザーに紐づく写真の内、引数 id で指定したIDを持つものを1つ取得します。
  #
  # @param [String] id 写真のID
  # @return [Photo < ActiveRecord] 写真モデル
  def find_my_photo_by(id:)
    photos.where(id: id).first
  end

  class << self

    # 指定した ユーザーID と パスワードでログイン可能かを判定します。
    #
    # * 判定結果に応じて、引数のコールバック用関数をコールします。
    #
    # @param [String] username ユーザーID
    # @param [String] password パスワード
    # @param [->(User < ActiveRecord){}] when_succeeded ログイン可能時のコールバック, 第１引数にはログインするユーザーモデルが渡されます
    # @param [->(){}] when_failed ログイン不能時のコールバック
    # @return [不使用]
    def authenticate(
      username:,
      password:,
      when_succeeded: ->(user) {},
      when_failed: -> {}
    )
      user = authenticated(username, password).first
      if user.present?
        when_succeeded.call user
      else
        when_failed.call
      end
    end

  end

end
