module ApplicationHelper
  FLASH_VARS = {
    notice: {
      bootstrap_class: 'success', #green
    },
    alert: {
      bootstrap_class: 'info', #blue
    },
    # alert: 'warning', #yellow
    error: {
      bootstrap_class: 'danger', #red
    }
  }

  def flash_alert_bar
    raw(%w(notice alert error).map do |flash_type|
      <<-MULTI_LINE
      <p class="flash-#{flash_type} alert-dismissible fade alert alert-#{FLASH_VARS[flash_type.to_sym][:bootstrap_class]}" style="#{'display: none;' if flash[flash_type].blank?}">
        #{flash[flash_type]}
      </p>
      MULTI_LINE
    end.join)
  end
end
