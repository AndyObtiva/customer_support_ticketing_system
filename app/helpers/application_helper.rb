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
    flash_alert_bars = FLASH_VARS.map do |type, props|
      flash_style = flash[type].blank? ? 'display: none;' : ''
      render('layouts/flash_alert_bar',
        flash_type: type,
        flash_props: props,
        flash_style: flash_style
      )
    end
    raw(flash_alert_bars.join)
  end
end
