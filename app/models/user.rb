class User < ApplicationRecord
  include EasilyTypable
  
  ROLES = ['Customer', 'SupportAgent', 'Admin']
  SIGN_UP_ROLES = ROLES.without('Admin')

  self.inheritance_column = 'role'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role,
    presence: true,
    inclusion: {
      in: User::ROLES,
      if: lambda {self.role.present?}
    }
end
