class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :price_in_cents, presence: true, numericality: { greater_than: 0 }
  validates_presence_of :category

  def get_price_with_discount(quantity)
    total_price = price_in_cents * quantity

    discount = Discount.enabled.
      where(category_id: category_id).
      where('from_num_of_items <= ?', quantity).
      order(volume: :desc).
      first

    if discount
      discount_price = total_price * (discount.volume.to_f / 100)
      total_price = total_price - discount_price
    end

    total_price
  end
end
