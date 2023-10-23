class Discount < ApplicationRecord
  belongs_to :category

  validates_presence_of :category
  validates :volume, :inclusion => { :in => 1..100 }
  validates :from_num_of_items, numericality: { greater_than: 0 }

  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
end
