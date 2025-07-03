require_relative 'pricing_rule'

Product = Struct.new(:code, :name, :price, :pricing_rule)

PRODUCTS = [
  ['GR1', 'Green Tea', 3.11, BuyOneGetOneFreeRule.new],
  ['SR1', 'Strawberries', 5.00, BulkDiscountRule.new(threshold: 3, discounted_price: 4.50)],
  ['CF1', 'Coffee', 11.23, VolumeDiscountRule.new(threshold: 3, factor: 2.0 / 3.0)]
].map do |code, name, price, pricing_rule|
  Product.new(code:, name:, price:, pricing_rule:)
end
