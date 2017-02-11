require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:customer) do
    Customer.create!(
      email: 'customer@example.com',
      password: 'pass,1234',
      password_confirmation: 'pass,1234'
    )
  end
  let(:support_agent) do
    SupportAgent.create!(
      email: 'support_agent@example.com',
      password: 'pass,1234',
      password_confirmation: 'pass,1234'
    )
  end
  let(:support_agent2) do
    SupportAgent.create!(
      email: 'support_agent2@example.com',
      password: 'pass,1234',
      password_confirmation: 'pass,1234'
    )
  end
  subject do
    Ticket.create!(
      support_request: 'Please help!',
      status: 'open',
      customer: customer
    )
  end
  describe 'closed_at' do
    it 'assigns closed_at upon closing ticket' do
      now = DateTime.new(2027, 10, 19)
      Timecop.freeze(now) do
        subject.closed!

        expect(subject.closed_at).to eq(now)
      end
    end
    it 'nullifies closed_at upon re-opening ticket' do
      subject.closed!
      subject.open!

      expect(subject.closed_at).to be_nil
    end
  end
  context 'defaults' do
    it 'defaults status to open after initialize' do
      expect(subject).to be_open
    end
  end
  context 'comments' do
    it 'assigns support agent upon comment by a support agent' do
      subject.comments.create!(
        body: 'Help is on its way.',
        user: support_agent
      )

      expect(subject.reload.support_agent).to eq(support_agent)
    end
    it 'does not assign support agent upon comment by customer' do
      subject.comments.create!(
        body: 'Help is on its way.',
        user: customer
      )

      expect(subject.reload.support_agent).to be_nil
    end
    it 'does not assign support agent upon comment by a different support agent' do
      subject.comments.create!(
        body: 'Help is on its way.',
        user: support_agent
      )
      subject.comments.create!(
        body: 'Do not listen to him. I can help you instead!',
        user: support_agent2
      )

      expect(subject.reload.support_agent).to eq(support_agent)
    end
  end
end
