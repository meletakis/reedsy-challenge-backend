class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :price_in_cents, presence: true, numericality: { greater_than: 0 }
  validates_presence_of :category
end
