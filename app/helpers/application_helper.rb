module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "layouts.application.title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      if type == "notice"
        text = "<script>toastr.success('#{message}');</script>"
        flash_messages << text.html_safe if message
      elsif type == "alert"
        text = "<script>toastr.error('#{message}');</script>"
        flash_messages << text.html_safe if message
      end
    end
    flash_messages.join("\n").html_safe
  end
end
