module ApplicationHelper

  def flash_alert_bar
    flash_type_bootstrap_alert = {
      notice: 'success', #green
      alert: 'info', #blue
      # alert: 'warning', #yellow
      error: 'danger', #red
    }
    raw(%w(notice alert error).map do |flash_type|
      <<-MULTI_LINE
      <p class="#{flash_type} alert-dismissible fade alert alert-#{flash_type_bootstrap_alert[flash_type.to_sym]}" style="#{'display: none' if flash[flash_type].blank?}">
        #{flash[flash_type]}
      </p>
      MULTI_LINE
    end.join)
  end
end
