When(/^Support Agent chooses to generate report for last one month's closed support request tickets$/) do
  page.find('#view_report').click
end
#
# Then(/^report is generated with the following support request tickets:$/) do |table|
#   # table is a Cucumber::MultilineArgument::DataTable
#   pending # Write code here that turns the phrase above into concrete actions
# end
#
# Then(/^generated report does not have the following support request tickets:$/) do |table|
#   # table is a Cucumber::MultilineArgument::DataTable
#   pending # Write code here that turns the phrase above into concrete actions
# end
