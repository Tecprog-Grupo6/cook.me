class Recipe < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true,
	length: {minimum: 10}
end
