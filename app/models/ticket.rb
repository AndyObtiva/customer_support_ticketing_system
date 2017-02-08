class Ticket < ApplicationRecord
  enum status: [:open, :closed]

  belongs_to :customer
  belongs_to :support_agent, optional: true
  has_many :comments

  validates :support_request, presence: true
end
