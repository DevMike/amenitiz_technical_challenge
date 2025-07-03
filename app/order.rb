require_relative 'product'

class Order
  def initialize
    @basket = []
  end

  def scan(code)
    product = PRODUCTS.detect { |product| product.code == code }
    raise "Unknown product code: #{code}" unless product

    @basket << product
  end

  def total
    @basket.group_by(&:code).sum do |_, products|
      product = products.first
      product.pricing_rule.apply(products.count, product.price)
    end.round(2)
  end
end
