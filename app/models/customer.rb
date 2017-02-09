class Customer < User
  has_many :tickets, foreign_key: 'customer_id'

  def default_ticket_query_filter
    {customer_id: self.id}
  end
end
