require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context 'single flash var' do
    describe 'flash_alert_bar' do
      {
        notice: 'success',
        alert: 'info',
        error: 'danger',
      }.each do |flash_var, flash_css_class|
        it "displays #{flash_var} flash var" do
          message = 'Notice Appears'
          flash[flash_var] = message
          expect(flash_alert_bar).to include(message)
        end
        it "uses #{flash_css_class} css class for #{flash_var} flash var" do
          flash[flash_var] = 'message'
          expect(flash_alert_bar).to include(flash_css_class)
        end
      end
    end
  end
  context 'multiple flash vars' do
    xit "displays multiple flash vars" do
      message = 'Notice Appears'
      flash[:notice] = 'Notice Appears'
      flash[:alert] = 'Alert Appears'
      flash[:error] = 'Error Appears'
      expect(flash_alert_bar).to include(message)
      expect(flash_alert_bar).to include(message)
      expect(flash_alert_bar).to include(message)
    end
  end
end
