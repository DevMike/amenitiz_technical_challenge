# 🧾 Amenitiz Technical Challenge – Checkout System

A flexible and test-driven Ruby checkout system developed for the Amenitiz backend technical challenge.

The application allows scanning products, applying promotional rules, and computing the final total. The system is modular and built for extensibility — adding new pricing rules or products is straightforward.

---

## ✅ Features

- Supports real-time scanning of product codes
- Applies promotional pricing rules:
  - **GR1 (Green Tea)**: Buy-One-Get-One-Free
  - **SR1 (Strawberries)**: Buy 3 or more → 4.50€ each
  - **CF1 (Coffee)**: Buy 3 or more → 2/3 of base price
- Flexible and pluggable pricing logic per product
- Fully tested with RSpec (test-first, TDD approach)
- CLI interface for interactive use
- Clean, extensible, and object-oriented architecture

---

## ⚙️ Requirements

- Ruby 3.0+
- Bundler (`gem install bundler`)

---

## 📦 Setup

```bash
git clone git@github.com:DevMike/amenitiz_technical_challenge.git
cd amenitiz_technical_challenge
bundle install
```

---

## 🧪 Running Tests

All tests are written with [RSpec](https://rspec.info/). To run the suite:

```bash
bundle exec rspec
```

Example output:

```
Order
  calculates total for GR1,GR1
  raises an error for unknown code
...

Finished in 0.02 seconds
8 examples, 0 failures
```

---

## ✍️ Writing Tests

To write a new spec:

1. Place it under `spec/`
2. Use `require_relative '../app/filename'`
3. Use RSpec’s `describe`, `let`, `it`, and `expect` blocks

Example test for a rule:

```ruby
describe BuyOneGetOneFreeRule do
  let(:rule) { BuyOneGetOneFreeRule.new }

  it 'applies 2-for-1 logic' do
    expect(rule.apply(2, 3.11)).to eq(3.11)
  end
end
```

Run a single test file:

```bash
bundle exec rspec spec/buy_one_get_one_free_rule_spec.rb
```

## 🔍 Code Quality and Security

### Run RuboCop

```bash
bundle exec rubocop
```
to auto correct
```bash
bundle exec rubocop -A
```

Run Bundle Audit to ensure your gems don't have any known vulnerabilities
```bash
bundle exec bundle-audit update
bundle exec bundle-audit
```

---

## 🛒 Using the CLI

Run:

```bash
ruby bin/console
```

Example usage:

```
> GR1
> CF1
> SR1
> done
Total: €...
```

---

## ➕ Adding a New Product

In `app/product.rb`, add a new line to the `PRODUCTS` list:

```ruby
Product.new('CH1', 'Chocolate', 2.50, MyCustomRule.new)
```

You can define `MyCustomRule` in `pricing_rule.rb` or a new file in `rules/`.

---

## 🧠 Creating a New Pricing Rule

Create a class that inherits from `PricingRule` and implements `#apply(quantity, unit_price)`:

```ruby
class FreeSampleRule < PricingRule
  def apply(quantity, unit_price)
    quantity == 1 ? 0 : quantity * unit_price
  end
end
```

Add your rule to a product in `PRODUCTS`:

```ruby
Product.new('FS1', 'Free Sample', 1.00, FreeSampleRule.new)
```

Then write tests for it in `spec/free_sample_rule_spec.rb`.

---

## 🧩 Extending with Combined Rules (future idea)

For more complex pricing, define a `PricingRuleSet` class:

```ruby
class PricingRuleSet
  def initialize(rules = [])
    @rules = rules
  end

  def apply(qty, unit_price)
    @rules.reduce(qty * unit_price) { |price, rule| rule.apply(qty, unit_price) }
  end
end
```

Use it like this:

```ruby
rule_set = PricingRuleSet.new([
  BuyOneGetOneFreeRule.new,
  TimeBasedDiscountRule.new(...)
])
Product.new('XYZ', 'Special Item', 10.0, rule_set)
```

---

## 🧠 Design Philosophy

* **Open/Closed Principle**: Add new pricing rules without touching existing logic
* **Delegation**: `Order` delegates pricing to each product’s `pricing_rule`
* **Encapsulation**: Each rule is tested in isolation
* **Composability**: Rule objects can be chained or swapped

---

## 📁 File Overview

```
.
├── bin/
│   └── console              # CLI entry point
├── app/                     # Application files dir
│   ├── order.rb             # Order class (scanning, grouping, total)
│   ├── pricing_rule.rb      # All pricing rule classes
│   ├── product.rb           # Products + pricing rules
├── spec/                    # RSpec test suite
│   ├── order_spec.rb
│   ├── pricing_rule_spec.rb
│   ├── product_spec.rb
├── README.md
```

---

## ✉️ Author

Mykhailo Zarechenskyi
Built with ❤️ for Amenitiz.
