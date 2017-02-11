require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:customer) {Customer.create!(email: 'customer@example.com', password: 'pass,1234', password_confirmation: 'pass,1234')}
  let(:ticket) {Ticket.create!(customer_id: customer.id, support_request: 'Help me!')}
  subject {
    Comment.create!(
    ticket_id: ticket.id,
    user_id: customer.id,
    body: 'Here are more details'
    )
  }
  describe 'as_json' do
    it 'includes user_email' do
      expect(subject.as_json[:user_email]).to eq(customer.email)
    end
    it 'includes user_role' do
      expect(subject.as_json[:user_role]).to eq(customer.role)
    end
  end
end
