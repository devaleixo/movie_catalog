class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one_attached :poster

  has_and_belongs_to_many :categories

  validates :title, :synopsis, :release_year, :duration, :director, presence: true
end
