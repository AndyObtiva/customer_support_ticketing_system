class Comment < ApplicationRecord
  include Wisper::Publisher
  belongs_to :ticket
  belongs_to :user

  after_commit :publish_created, on: :create

  validates :body, presence: true

  def as_json(options = nil)
    super(options).merge({
      user_email: user.email,
      user_role: user.role,
    })
  end

  def publish_created
    broadcast(:comment_created, self)
  end

end
