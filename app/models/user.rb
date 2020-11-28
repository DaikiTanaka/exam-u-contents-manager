class User < ApplicationRecord
  include PasswordEncryption

  has_many :photos

  scope :authenticated, lambda { |username, password|
    where(username: username).where(encrypted_password: PasswordEncryption.encrypt(password))
  }

  def password=(new_password)
    self.encrypted_password = encrypt(new_password)
  end

  def find_my_photo_by(id:)
    photos.where(id: id).first
  end

  def self.authenticate(
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
