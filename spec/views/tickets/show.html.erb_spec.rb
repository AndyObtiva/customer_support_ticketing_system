require 'rails_helper'

RSpec.describe "tickets/show", type: :view do
  let(:customer) {
    Customer.create!(
      email: 'customer@example.com',
      password: 'pass1234',
      password_confirmation: 'pass1234')
  }
  let(:support_agent) {
    SupportAgent.create!(
      email: 'support_agent@example.com',
      password: 'pass1234',
      password_confirmation: 'pass1234')
  }
  before(:each) do
    @ticket = assign(:ticket, Ticket.create!(
      :support_request => "MyText",
      :status => "open",
      :customer_id => customer.id,
      :support_agent_id => support_agent.id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/open/)
    expect(rendered).to match(/#{customer.email}/)
    expect(rendered).to match(/#{support_agent.email}/)
  end
end
