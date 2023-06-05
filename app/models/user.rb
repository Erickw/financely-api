class User < ApplicationRecord
  validates :name, presence: true
	validates :email, presence: true
	validates :firebase_id, uniqueness: true

  has_many :cards
end
