require 'rails_helper'

RSpec.describe LastOneMonthClosedTicketsReport, type: :model do
  describe 'generate' do
    let(:current_date) {DateTime.new(2027, 10, 19)}
    let(:customer) {
      Customer.create!(
        email: 'customer@example.com',
        password: 'pass,1234',
        password_confirmation: 'pass,1234'
      )
    }
    before do
      Timecop.freeze(current_date)
      Ticket.create!(support_request: 'help 1', closed_at: DateTime.new(2027, 10, 19), status: 'open', customer: customer)
      Ticket.create!(support_request: 'help 2', closed_at: DateTime.new(2027, 10, 19, 23, 59, 59), status: 'closed', customer: customer)
      Ticket.create!(support_request: 'help 3', closed_at: DateTime.new(2027, 10, 18), status: 'open', customer: customer)
      Ticket.create!(support_request: 'help 4', closed_at: DateTime.new(2027, 10, 18), status: 'closed', customer: customer)
      Ticket.create!(support_request: 'help 5', closed_at: DateTime.new(2027, 9, 19), status: 'open', customer: customer)
      Ticket.create!(support_request: 'help 6', closed_at: DateTime.new(2027, 9, 19), status: 'closed', customer: customer)
      Ticket.create!(support_request: 'help 7', closed_at: DateTime.new(2027, 9, 18), status: 'open', customer: customer)
      Ticket.create!(support_request: 'help 8', closed_at: DateTime.new(2027, 9, 18), status: 'closed', customer: customer)

      subject.generate
    end
    after do
      Timecop.return
    end

    it 'assigns closed tickets within last one month' do
      expected_tickets = [
        Ticket.find_by(closed_at: DateTime.new(2027, 10, 19, 23, 59, 59), status: 'closed'),
        Ticket.find_by(closed_at: DateTime.new(2027, 10, 18), status: 'closed'),
        Ticket.find_by(closed_at: DateTime.new(2027, 9, 19), status: 'closed'),
      ]

      expect(subject.tickets).to match_array(expected_tickets)
    end
  end
end
