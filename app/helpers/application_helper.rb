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
    FLASH_VARS.map do |flash_type, flash_props|
      render('layouts/flash_alert_bar',
        flash_type: flash_type,
        flash_props: flash_props
      )
    end.join
  end
end
