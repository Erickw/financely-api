class Card < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bills
end
