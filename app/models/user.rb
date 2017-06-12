# File name: user.rb
# Class name: User
# Description: This class define all the validates and relationships's User

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :active_follow_associations, class_name:  "FollowAssociation",
                                 foreign_key: "follower_id",
                                 dependent:   :destroy
  has_many :passive_follow_associations, class_name:  "FollowAssociation",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :following, through: :active_follow_associations, source: :followed
  has_many :followers, through: :passive_follow_associations, source: :follower
  has_many :active_chat_rooms, class_name:  "ChatRoom",
                                 foreign_key: "user_one_id",
                                 dependent:   :destroy
  has_many :passive_chat_rooms, class_name:  "ChatRoom",
                                    foreign_key: "user_two_id",
                                    dependent:   :destroy
  has_many :active_chat_rooms_users, through: :active_chat_rooms, source: :user_two
  has_many :passive_chat_rooms_users, through: :passive_chat_rooms, source: :user_one
  has_many :messages

  validates :first_name, presence: true, length: { maximum: 255, minimum: 3 }
  validates :last_name, presence: true, length: { maximum: 255, minimum: 3 }
  validates :password, presence: true, length: { maximum: 255, minimum: 6 }
  validates :password_confirmation, presence: true, length: { maximum: 255, minimum: 6 }
  validates :username, presence: true, length: { maximum: 255, minimum: 3 }

  #The birthday must be formated by day/month/year
  validates :birthday, presence: true, format: {:with => /\d{day}\/\d{month}\/\d{year}/, :on => :save}

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/system/no_photo/no_photo_user.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # Follows a user
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user
  def following?(other_user)
    following.include?(other_user)
  end

  # Starts a chat with the other user
  def start_chat(other_user)
    active_chat_rooms_users << other_user
  end

  # Finishes a chat with the other user
  def finish_chat(other_user)
    active_chat_rooms_users.delete(other_user)
  end

  # Returns true if the current user started a chat with the other user
  def started_chat?(other_user)
    active_chat_rooms_users.include?(other_user)
  end

  # Returns true if the current user started a chat with the other user or
  # if the other user started a chat with the current user
  def has_chat?(other_user)
    if active_chat_rooms_users.include?(other_user) or passive_chat_rooms_users.include?(other_user)
      return true
    else
      return false
    end
  end

end
