class Block < ApplicationRecord
  validates :name, presence: true
end
