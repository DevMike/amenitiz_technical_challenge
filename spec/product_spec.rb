require_relative '../app/product'

RSpec.describe 'PRODUCTS' do
  it 'has correct names and prices' do
    expect(PRODUCTS).to include(
                          have_attributes(code: 'GR1', name: 'Green Tea', price: 3.11),
                          have_attributes(code: 'SR1', name: 'Strawberries', price: 5.00),
                          have_attributes(code: 'CF1', name: 'Coffee', price: 11.23)
                        )
  end
end
