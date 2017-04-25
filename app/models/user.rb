class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { maximum: 255, minimum: 3 }
  validates :last_name, presence: true, length: { maximum: 255, minimum: 3 }
  validates :password, presence: true, length: { maximum: 255, minimum: 6 }
  validates :password_confirmation, presence: true, length: { maximum: 255, minimum: 6 }
  validates :username, presence: true, length: { maximum: 255, minimum: 3 }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
