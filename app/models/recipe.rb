class Recipe < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 4}
	belongs_to :user

	has_attached_file :image_one, styles: { medium: "300x300>", thumb: "100x100>" },
		default_url: "/system/no_photo/no_photo_recipe.jpg"
	validates_attachment_content_type :image_one, content_type: /\Aimage\/.*\z/
end
