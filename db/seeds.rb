# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.destroy_all
Discount.destroy_all
Category.destroy_all

# Code         | Name                   |  Price
# -------------------------------------------------
# MUG          | Reedsy Mug             |   6.00
# TSHIRT       | Reedsy T-shirt         |  15.00
# HOODIE       | Reedsy Hoodie          |  20.00

mugs = Category.create!(name: 'MUG')
tshirts = Category.create!(name: 'TSHIRT')
hoodies = Category.create!(name: 'HOODIE')

Product.create!([{
  name: 'Reedsy Mug',
  category: mugs,
  price_in_cents: 600
},
{
  name: 'Reedsy T-shirt',
  category: tshirts,
  price_in_cents: 1500
},
{
  name: 'Reedsy Hoodie',
  category: hoodies,
  price_in_cents: 2000
}])

p "Created #{Product.count} products and #{Category.count} categories"

# 30% discounts on all TSHIRT items when buying 3 or more.
Discount.create!(
  category: tshirts,
  volume: 30,
  from_num_of_items: 3,
  enabled: true
)

=begin
Volume discount for MUG items:
  2% discount for 10 to 19 items
  4% discount for 20 to 29 items
  6% discount for 30 to 39 items
  ... (and so forth with discounts increasing in steps of 2%)
  # 30% discount for 150 or more items
=end
from_num_of_items = 10

(2..30).step(2).to_a.each do |volume|
  Discount.create!(
    category: mugs,
    volume: volume,
    from_num_of_items: from_num_of_items,
    enabled: true
  )

  from_num_of_items += 10
end

p "Created #{Discount.count} discount records"
