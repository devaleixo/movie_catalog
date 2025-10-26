class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :poster

  has_and_belongs_to_many :categories

  validates :title, :synopsis, :release_year, :duration, :director, presence: true
  validates :title, uniqueness: { case_sensitive: false, message: "já existe no catálogo" }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true

  before_validation :format_text_fields
  
  # Helper method to render star rating
  def star_rating
    return 0 if rating.nil?
    rating.to_f
  end

  private

  def format_text_fields
    self.title = title.titleize if title.present?
    self.director = director.titleize if director.present?
  end
end
