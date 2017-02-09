class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :body, presence: true

  def as_json(options = nil)
    super(options).merge({
      user_email: user.email
    })
  end
end
