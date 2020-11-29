# エラーメッセージの蓄積と取得機能を提供します。
module WholeErrorMessage
  extend ActiveSupport::Concern

  included do
    helper_method :whole_error_messages
  end

  protected

  # エラーメッセージを1つ蓄積します。
  #
  # * Controller の before_action に設定してください。
  #
  # @param [String] message 蓄積したいエラーメッセージ
  # @return [Array.String] 蓄積された全てのメッセージ
  def add_whole_error_message(message)
    @_whole_error_messages ||= []
    @_whole_error_messages << message
    @_whole_error_messages
  end

  # 蓄積したエラーメッセージを全て取得します。
  #
  # @return [Array.String] 蓄積された全てのメッセージ
  def whole_error_messages
    @_whole_error_messages || []
  end

end
