require 'rails_helper'

RSpec.describe "tickets/new", type: :view do
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
    assign(:ticket, Ticket.new(
      :support_request => "MyText",
      :status => "open",
      :customer_id => customer.id,
      :support_agent_id => 1
    ))
  end

  it "renders new ticket form" do
    render

    assert_select "form[action=?][method=?]", tickets_path, "post" do

      assert_select "textarea#ticket_support_request[name=?]", "ticket[support_request]"

      # assert_select "input#ticket_status[name=?]", "ticket[status]"

      assert_select "input#ticket_customer_id[name=?]", "ticket[customer_id]"

      assert_select "input#ticket_support_agent_id[name=?]", "ticket[support_agent_id]"
    end
  end
end
