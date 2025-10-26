class Category < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "já existe" }

  before_validation :format_name
  before_destroy :check_for_movies

  private

  def format_name
    self.name = name.titleize if name.present?
  end

  def check_for_movies
    if movies.any?
      errors.add(:base, "Não é possível excluir categoria com filmes associados. Remova os filmes primeiro.")
      throw(:abort)
    end
  end
end
