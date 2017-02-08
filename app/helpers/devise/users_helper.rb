module Devise
  module UsersHelper
    def user_sign_up_roles
      humanized_sign_up_roles = User::SIGN_UP_ROLES.map(&:underscore).map(&:humanize).map(&:titleize)
      humanized_sign_up_roles.zip(User::SIGN_UP_ROLES)
    end
  end
end
