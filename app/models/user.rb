class User < ApplicationRecord
  include PasswordEncryption

  def password=(new_password)
    self.encrypted_password = encrypt(new_password)
  end

end
