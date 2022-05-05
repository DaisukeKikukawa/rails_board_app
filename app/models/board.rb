class Board < ApplicationRecord
  mount_uploader :board_image, ImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: {maximum: 65535}, presence: true
end
