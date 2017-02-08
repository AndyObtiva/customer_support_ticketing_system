class Customer < User
  has_many :tickets, foreign_key: 'customer_id'
end
