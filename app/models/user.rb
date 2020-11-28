class User < ApplicationRecord
  include PasswordEncryption

  has_many :photos

  def password=(new_password)
    self.encrypted_password = encrypt(new_password)
  end

end
