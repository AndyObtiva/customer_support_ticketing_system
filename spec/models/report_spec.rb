require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'constructor' do
    it 'does not work for being an abstract class' do
      expect {Report.new}.to raise_error(NotImplementedError)
    end
  end
  context 'subclass for concrete report missing abstract method' do
    let(:concrete_report_missing_abstract_method_class) do
      class ConcreteReportMissingAbstractMethod < Report
      end
      ConcreteReportMissingAbstractMethod
    end
    let(:concrete_report_missing_abstract_method) {concrete_report_missing_abstract_method_class.new}
    it 'fails definition for missing abstract method' do
      expect {concrete_report_missing_abstract_method.generate}.to raise_error(NotImplementedError)
    end
  end
  context 'subclass for concrete report implementing abstract method' do
    let(:concrete_report_class) do
      class ConcreteReport < Report
        def generate_report
          customer = Customer.create!(
            email: 'customer@example.com',
            password: 'pass,1234',
            password_confirmation: 'pass,1234'
          )
          self.tickets = [
            Ticket.create!(
              support_request: 'Help 1',
              customer_id: customer.id
            )
          ]
        end
      end
      ConcreteReport
    end
    let(:concrete_report) {concrete_report_class.new}
    describe 'name' do
      it 'titlizes class name' do
        expect(concrete_report.name).to eq('Concrete Report')
      end
    end
    describe 'generate' do
      let(:now) {DateTime.new(2017,10,10)}
      it 'timestamps report' do
        Timecop.freeze(now) do
          expect(concrete_report.generated_at).to be_nil
          concrete_report.generate
          expect(concrete_report.generated_at).to eq(now)
        end
      end
      it 'invokes generate_report in subclass, setting tickets' do
        expect(concrete_report.tickets).to be_blank
        concrete_report.generate
        expect(concrete_report.tickets).to_not be_blank
      end
    end
  end
end
