require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'flash_alert_bar' do
    context 'single flash var' do
      ApplicationHelper::FLASH_VARS.each_pair do |flash_var, flash_props|
        context flash_var do
          let!(:message) {"#{flash_var} appears".titleize}
          before {flash[flash_var] = message}
          let!(:doc) {Nokogiri::HTML(flash_alert_bar)} #relies on before block
          let!(:flash_var_alert_element) {doc.at_css(".flash-#{flash_var}")}
          let!(:other_flash_vars) {ApplicationHelper::FLASH_VARS.keys - [flash_var]}
          it "displays #{flash_var} flash var element" do
            flash_var_alert_message = flash_var_alert_element.children.select(&:text?).map(&:to_s).join rescue ''
            expect(flash_var_alert_message).to include(message)
          end
          it "displays #{flash_var} flash var message" do
            flash_var_alert_style = flash_var_alert_element.attribute('style').value rescue ''
            expect(flash_var_alert_style).to_not include('display: none;')
          end
          it "includes #{flash_var} bootstrap class" do
            flash_var_alert_class = flash_var_alert_element.attribute('class').value rescue ''
            expect(flash_var_alert_class).to include(flash_props[:bootstrap_class])
          end
          it "ensures other flash vars are hidden" do
            other_flash_vars.each do |other_flash_var|
              flash_var_alert_element = doc.at_css(".flash-#{other_flash_var}")
              flash_var_alert_style = flash_var_alert_element.attribute('style').value rescue ''
              expect(flash_var_alert_style).to include('display: none;')
            end
          end
        end
      end
    end
    context 'multiple flash vars' do
      it "displays two flash vars" do
        flash[:notice] = 'Notice Appears'
        flash[:alert] = 'Alert Appears'

        doc = Nokogiri::HTML(flash_alert_bar)
        notice_bar = doc.at_css(".flash-notice")
        alert_bar = doc.at_css(".flash-alert")
        error_bar = doc.at_css(".flash-error")

        expect(notice_bar.attribute('style').value).to_not include('display: none;')
        expect(alert_bar.attribute('style').value).to_not include('display: none;')
        expect(error_bar.attribute('style').value).to include('display: none;')
      end
      it "displays all three flash vars" do
        flash[:notice] = 'Notice Appears'
        flash[:alert] = 'Alert Appears'
        flash[:error] = 'Error Appears'

        doc = Nokogiri::HTML(flash_alert_bar)
        notice_bar = doc.at_css(".flash-notice")
        alert_bar = doc.at_css(".flash-alert")
        error_bar = doc.at_css(".flash-error")

        expect(notice_bar.attribute('style').value).to_not include('display: none;')
        expect(alert_bar.attribute('style').value).to_not include('display: none;')
        expect(error_bar.attribute('style').value).to_not include('display: none;')
      end
    end
    context 'no flash vars' do
      it "displays no flash vars" do
        ApplicationHelper::FLASH_VARS.each_pair do |flash_var, _|
          doc = Nokogiri::HTML(flash_alert_bar)
          notice_bar = doc.at_css(".flash-notice")
          alert_bar = doc.at_css(".flash-alert")
          error_bar = doc.at_css(".flash-error")

          expect(notice_bar.attribute('style').value).to include('display: none;')
          expect(alert_bar.attribute('style').value).to include('display: none;')
          expect(error_bar.attribute('style').value).to include('display: none;')
        end
      end
    end
  end
end
