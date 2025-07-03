require_relative '../app/order'

RSpec.describe Order do
  let(:order) { described_class.new }

  describe '#total_price' do
    subject { order.total }

    shared_examples_for 'calculates total price' do |product_codes, expected_total_price|
      it do
        product_codes.each { |code| order.scan(code) }
        expect(subject).to eq(expected_total_price)
      end
    end

    it_behaves_like 'calculates total price', %w[GR1 GR1], 3.11
    it_behaves_like 'calculates total price', %w[SR1 SR1 GR1 SR1], 16.61
    it_behaves_like 'calculates total price', %w[GR1 CF1 SR1 CF1 CF1], 30.57
  end

  describe '#scan' do
    subject { order.scan(code) }

    context 'with valid code' do
      let(:code) { 'GR1' }

      it { expect { subject }.not_to raise_error('Unknown product code: GR1') }
    end

    context 'with invalid code' do
      let(:code) { 'XYZ' }

      it { expect { subject }.to raise_error('Unknown product code: XYZ') }
    end
  end
end
