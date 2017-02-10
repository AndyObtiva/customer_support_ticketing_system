class Ticket < ApplicationRecord
  enum status: [:open, :closed]

  belongs_to :customer
  belongs_to :support_agent, optional: true
  has_many :comments

  validates :support_request, presence: true, length: {maximum: 512}

  before_save :set_closed_at
  after_initialize :set_defaults
  after_initialize :subscribe_to_comment_events

  # Wisper event listener to Comment Wisper::Publisher (Observer Design Pattern)
  def comment_created(comment)
    if support_agent.blank? && comment.user.support_agent?
      self.update(support_agent: comment.user)
    end
  end

  private

  def subscribe_to_comment_events
    Comment.subscribe(self)
  end

  def set_closed_at
    if self.status_changed?
      if self.closed? && self.closed_at.blank?
        self.closed_at = DateTime.current
      elsif self.open? && self.closed_at.present?
        self.closed_at = nil
      end
    end
  end

  def set_defaults
    if self.status.blank?
      self.open!
    end
  end
end
