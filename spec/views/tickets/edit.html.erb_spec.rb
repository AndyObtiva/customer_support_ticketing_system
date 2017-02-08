require 'rails_helper'

RSpec.describe "tickets/edit", type: :view do
  include Devise::Test::ControllerHelpers
  let(:customer) {
    Customer.create!(
      email: 'customer@example.com',
      password: 'pass1234',
      password_confirmation: 'pass1234')
  }
  before(:each) do
    sign_in customer
    @ticket = assign(:ticket, Ticket.create!(
      :support_request => "MyText",
      :status => "open",
      :customer_id => customer.id,
      :support_agent_id => 1
    ))
  end

  it "renders the edit ticket form" do
    render

    assert_select "form[action=?][method=?]", ticket_path(@ticket), "post" do

      assert_select "textarea#ticket_support_request[name=?]", "ticket[support_request]"

      assert_select "input#ticket_customer_id[name=?]", "ticket[customer_id]"

      assert_select "input#ticket_support_agent_id[name=?]", "ticket[support_agent_id]"
    end
  end
end
