module PasswordEncryption

  # 文字列を暗号化します。
  #
  # @param [String] text 任意の文字列
  # @return [String] 引数 text が暗号化された文字列
  def encrypt(text)
    PasswordEncryption.encrypt(text)
  end

  class << self

    # 文字列を暗号化します。
    #
    # * 本モジュールを include したくない/できない場合はこちらを利用してください。
    #
    # @param [String] text 任意の文字列
    # @return [String] 引数 text が暗号化された文字列
    def encrypt(text)
      text.crypt(PASSWORD_ENCRYPTION_SECRET)
    end

  end

end
