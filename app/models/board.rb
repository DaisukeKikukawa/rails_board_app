class Board < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: {maximum: 65535}, presence: true
end
