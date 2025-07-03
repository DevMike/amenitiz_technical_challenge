require_relative '../app/pricing_rule'

RSpec.describe 'Pricing Rules' do
  describe BuyOneGetOneFreeRule do
    let(:rule) { BuyOneGetOneFreeRule.new }

    describe '#apply' do
      subject { rule.apply(quantity, price) }

      let(:price) { 3.11 }

      context 'with 0 items' do
        let(:quantity) { 0 }

        it { is_expected.to eq 0 }
      end

      context 'with 1 item' do
        let(:quantity) { 1 }

        it { is_expected.to eq 3.11 }
      end

      context 'with 2 items' do
        let(:quantity) { 2 }

        it { is_expected.to eq 3.11 }
      end

      context 'with 3 items' do
        let(:quantity) { 3 }

        it { is_expected.to eq 6.22 }
      end
    end
  end

  describe BulkDiscountRule do
    subject { rule.apply(quantity, price) }

    let(:rule) { BulkDiscountRule.new(threshold:, discounted_price:) }
    let(:threshold) { 3 }
    let(:discounted_price) { 4.5 }

    context 'when quantity is below the threshold' do
      let(:quantity) { 2 }
      let(:price) { 5 }

      it 'applies full price' do
        is_expected.to eq(10)
      end
    end

    context 'when quantity is at the threshold' do
      let(:quantity) { 3 }
      let(:price) { 5 }

      it 'applies the discount' do
        is_expected.to eq(13.5)
      end
    end
  end

  describe VolumeDiscountRule do
    subject { rule.apply(quantity, price) }

    let(:rule) { VolumeDiscountRule.new(threshold:, factor: ) }
    let(:threshold) { 3 }
    let(:factor) { 2.0 / 3.0 }

    context 'when quantity is below the threshold' do
      let(:quantity) { 2 }
      let(:price) { 11.23 }

      it 'applies full price' do
        is_expected.to eq(22.46)
      end
    end

    context 'when quantity is at the threshold' do
      let(:quantity) { 3 }
      let(:price) { 11.23 }

      it 'applies the discount' do
        is_expected.to eq(22.46)
      end
    end
  end
end
