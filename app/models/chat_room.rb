class ChatRoom < ApplicationRecord
  belongs_to :user_one, class_name: "User"
  belongs_to :user_two, class_name: "User"

  validates :user_one_id, presence: true
  validates :user_two_id, presence: true

  has_many :messages, dependent: :destroy
end
