class Bill < ApplicationRecord
  belongs_to :card, optional: true
end
