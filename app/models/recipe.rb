class Recipe < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 4}
	belongs_to :user
	has_many :comments, dependent: :destroy
end
