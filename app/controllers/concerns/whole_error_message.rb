module WholeErrorMessage
  extend ActiveSupport::Concern

  included do
    helper_method :whole_error_messages
  end

  protected

  def add_whole_error_message(message)
    @_whole_error_messages ||= []
    @_whole_error_messages << message
    @_whole_error_messages
  end

  def whole_error_messages
    @_whole_error_messages || []
  end

end
