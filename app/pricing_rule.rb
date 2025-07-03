class PricingRule
  def apply(quantity, unit_price)
    raise NotImplementedError
  end
end

class BuyOneGetOneFreeRule < PricingRule
  # For every 2, one is free. So, for 'count' items, 'count // 2' are free.
  # The number of items to charge for is 'count - (count / 2).floor'
  # which simplifies to '(count + 1) / 2' using integer division logic.
  # Example: 2 items -> (2+1)/2 = 1.
  # Example: 3 items -> (3+1)/2 = 2.
  # Example: 4 items -> (4+1)/2 = 2.
  def apply(quantity, unit_price)
    effective_qty = (quantity / 2) + (quantity % 2)
    effective_qty * unit_price
  end
end

class BulkDiscountRule < PricingRule
  # Applies the bulk discount rule to a given quantity of items.
  #
  # If the quantity is greater than or equal to the defined threshold,
  # the `discounted_price` is used for all items; otherwise, the original
  # `unit_price` is used.
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
  # Applies the volume discount rule to a given quantity of items.
  #
  # If the quantity is greater than or equal to the defined threshold,
  # the `unit_price` is multiplied by the `factor` for all items;
  # otherwise, the original `unit_price` is used.
  def initialize(threshold:, factor:)
    @threshold = threshold
    @factor = factor
  end

  def apply(quantity, unit_price)
    discounted_price = quantity >= @threshold ? unit_price * @factor : unit_price
    quantity * discounted_price
  end
end
