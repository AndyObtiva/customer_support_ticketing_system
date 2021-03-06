When(/^Customer chooses to create a support request ticket$/) do
  page.find('#request_support').click
end

When(/^Customer submits valid support request ticket form details$/) do
  fill_in "ticket_support_request", :with => "Please help me!"
  page.find('.new_ticket input[type=submit][name=commit]').click
end

Then(/^Ticket is stored$/) do
  expect(Ticket.find_by(support_request: "Please help me!")).to_not be_nil
end

Then(/^Customer is presented with a confirmation for storing support request ticket$/) do
  expect(page.text).to include('Ticket was successfully created')
end

Given(/^Customer has following support request tickets:$/) do |table|
  customer = Customer.find_by(email: 'customer@example.com')
  table.hashes.each do |ticket_attributes|
    support_request = ticket_attributes['Support Request']
    status = ticket_attributes['Status']
    ticket = Ticket.create!(
      support_request: support_request,
      customer_id: customer.id,
      status: status
    )
  end
end

When(/^Customer chooses to list own support request tickets$/) do
  page.find('#check_status_of_previous_requests').click
end

Then(/^.* is presented with the following support request tickets:$/) do |table|
  table.hashes.each do |ticket_attributes|
    support_request = ticket_attributes['Support Request']
    expect(page.text).to include(support_request)
  end
end

Given(/^the following support request tickets exist in system:$/) do |table|
  table.hashes.each_with_index do |ticket_attributes, i|
    support_request = ticket_attributes['Support Request']
    customer = Customer.find_by(email: ticket_attributes['Customer Email']) ||
      Customer.create!(
        email: "other_customer#{i}@example.com",
        password: "pass,1234",
        password_confirmation: "pass,1234"
      )
    status = ticket_attributes['Status']
    closed_at = ticket_attributes['Closed At']
    Ticket.create!(
      support_request: support_request,
      customer: customer,
      status: status,
      closed_at: closed_at
    )
  end
end

Then(/^.+ is not presented with the following support request tickets:$/) do |table|
  table.hashes.each do |ticket_attributes|
    support_request = ticket_attributes['Support Request']
    expect(page.text).to_not include(support_request)
  end
end

When(/^Support Agent chooses to list open support request tickets$/) do
  page.find('#respond_to_customer_tickets').click
end

When(/^Support Agent chooses to filter by (.+) support request tickets$/) do |filter|
  page.find("#filter_by_#{filter}_tickets").click
end

When(/^.+ chooses to view support request ticket "([^"]*)"$/) do |support_request|
  page.find_all('.ticket').each do |row|
    if row.text.include?(support_request)
      row.find('.show_ticket_action').click
    end
  end
end

Then(/^.+ is presented with support request ticket status and details of "([^"]*)"$/) do |support_request|
  ticket = Ticket.find_by(support_request: support_request)
  expect(page.text).to include(support_request)
  expect(page.text).to include(ticket.customer.email)
  expect(page.text.downcase).to include(ticket.status)
end

When(/^.+ submits comment "([^"]*)"$/) do |comment|
  fill_in "comment_body", :with => comment
  page.find('.new_comment input[type=submit]').click
end

Then(/^.+ is presented with comment "([^"]*)"$/) do |comment|
  expect(page.text).to include(comment)
  expect(page.find('#comment_body').text).to_not include(comment)
end

When(/^.+ closes support request ticket "([^"]*)"$/) do |arg1|
  page.find('#close_ticket_action').click
end

Then(/^.+ is presented with support request ticket "([^"]*)" having status "([^"]*)"$/) do |support_request, status|
  expect(page.text).to include(status)
end

Then(/^.+ cannot submit comments$/) do
  expect(page.find('#comment_body')).to be_disabled
  expect(page.find('#new_comment input[type=submit]')).to be_disabled
end

When(/^.+ re-opens support request ticket "([^"]*)"$/) do |arg1|
  page.find('#reopen_ticket_action').click
end

Then(/^.+ can submit comments$/) do
  expect(page.find('#comment_body')).to_not be_disabled
  expect(page.find('#new_comment input[type=submit]')).to_not be_disabled
end
