class User < ApplicationRecord
  include EasilyTypable

  ROLES = ['Customer', 'SupportAgent', 'Admin']
  SIGN_UP_ROLES = ROLES.without('Admin')

  self.inheritance_column = 'role'

  has_many :comments
  has_many :commented_tickets, class_name: 'Ticket', foreign_key: 'ticket_id', through: :comments

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

  # note: covered by Cucumber test
  def filtered_tickets(filter=nil)
    filter ||= default_ticket_filter
    query_filter = {}
    case filter
    when 'open'
      query_filter = {status: 'open'}
    when 'closed'
      query_filter = {status: 'closed'}
    when 'all'
      query_filter = {status: ['open', 'closed']}
    end
    query_criteria = query_filter.merge(additional_ticket_query_filter)
    puts 'Customers'
    puts Customer.all.inspect
    puts 'Tickets'
    puts Ticket.all.inspect
    puts '>>>query_criteria.inspect'
    puts query_criteria.inspect
    results = Ticket.where(query_criteria)
    puts '>>>results.inspect'
    puts results.inspect
    [results, filter]
  end

  protected
  def additional_ticket_query_filter
    {}
  end
  def default_ticket_filter
    'all'
  end
end
