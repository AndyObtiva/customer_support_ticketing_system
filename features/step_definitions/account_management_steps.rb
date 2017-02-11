Given(/^(.+) is signed in$/) do |role_name|
  role = role_name.split.join
  user = role.constantize.create(
    email: "#{role.underscore}@example.com",
    password: 'pass,1234',
    password_confirmation: 'pass,1234'
  )

  visit '/users/sign_in'
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.password
  page.find('.new_user input[type=submit][name=commit]').click
end
