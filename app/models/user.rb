class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes

  validates :name, presence: true
  validates :bio, presence: true, length: { maximum: 250 }
  validates :password, presence: true
end
