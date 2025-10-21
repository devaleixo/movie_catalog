class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one_attached :poster
end
