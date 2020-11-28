module PasswordEncryption
  def encrypt(text)
    PasswordEncryption.encrypt(text)
  end

  def self.encrypt(text)
    text.crypt(PASSWORD_ENCRYPTION_SECRET)
  end
end