require 'rails_helper'

RSpec.describe "tickets/index", type: :view do
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
    assign(:tickets, [
      Ticket.create!(
        :support_request => "MyText",
        :status => "open",
        :customer_id => customer.id,
        :support_agent_id => support_agent.id
      ),
      Ticket.create!(
        :support_request => "MyText",
        :status => "open",
        :customer_id => customer.id,
        :support_agent_id => support_agent.id
      )
    ])
  end

  it "renders a list of tickets" do
    render template: 'tickets/index', locals: {current_user: customer}
    puts response.inspect
    assert_select "tr>td.ticket_support_request", :text => "MyText".to_s, :count => 2
    assert_select "tr>td.ticket_status", :text => "open".to_s, :count => 2
    assert_select "tr>td.ticket_customer", :text => customer.email.to_s, :count => 2
    assert_select "tr>td.ticket_support_agent", :text => support_agent.email.to_s, :count => 2
  end
end
