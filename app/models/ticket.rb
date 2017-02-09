class Ticket < ApplicationRecord
  enum status: [:open, :closed]

  belongs_to :customer
  belongs_to :support_agent, optional: true
  has_many :comments

  validates :support_request, presence: true

  before_save :set_closed_at

  private

  def set_closed_at
    if self.status_changed?
      if self.closed? && self.closed_at.blank?
        self.closed_at = DateTime.current
      elsif self.open? && self.closed_at.present?
        self.closed_at = nil
      end
    end
  end
end
