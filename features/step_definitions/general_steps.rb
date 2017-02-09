Then /^show me the page$/ do
  save_and_open_page
end

Given(/^current date is (\d+)\/(\d+)\/(\d+)$/) do |year, month, day|
  Timecop.freeze(Date.new(year.to_i, month.to_i, day.to_i))
end

After do
  Timecop.return
end
