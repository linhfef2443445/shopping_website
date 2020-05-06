# frozen_string_literal: true

module FlashHelper
  def flash_messages(_options = {})
    flash_messages = []
    flash.each do |type, message|
      type = type.to_sym
      type = :success if type == :notice
      type = :error   if type == :alert
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
