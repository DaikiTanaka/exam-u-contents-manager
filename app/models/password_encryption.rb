module PasswordEncryption
  def encrypt(text)
    text.crypt(PASSWORD_ENCRYPTION_SECRET)
  end
end