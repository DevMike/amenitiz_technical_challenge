class PricingRule
  def apply(quantity, unit_price)
    raise NotImplementedError
  end
end

class BuyOneGetOneFreeRule < PricingRule
  def apply(quantity, unit_price)
    effective_qty = (quantity / 2) + (quantity % 2)
    effective_qty * unit_price
  end
end

class BulkDiscountRule < PricingRule
  def initialize(threshold:, discounted_price:)
    @threshold = threshold
    @discounted_price = discounted_price
  end

  def apply(quantity, unit_price)
    price = quantity >= @threshold ? @discounted_price : unit_price
    quantity * price
  end
end

class VolumeDiscountRule < PricingRule
  def initialize(threshold:, factor:)
    @threshold = threshold
    @factor = factor
  end

  def apply(quantity, unit_price)
    discounted_price = quantity >= @threshold ? unit_price * @factor : unit_price
    quantity * discounted_price
  end
end
