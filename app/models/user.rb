class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies
  has_many :comments
  has_many :import_statuses
end
