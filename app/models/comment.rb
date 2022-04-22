class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :body, length: {maximum: 65535}, presence: true
end
