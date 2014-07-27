require 'minitest/autorun'
require 'minitest/spec'
require 'bitvector'

module BitVector
  describe BitVector do
    let(:bit_vector) { BitVector.new }

    describe '#to_string' do
      subject { bit_vector.to_s }

      describe 'with empty vector' do
        it 'returns all zeros vector' do
          subject.must_equal('00000000000000000000000000000000')
        end
      end

      describe 'with value 5' do
        let(:bit_vector) { BitVector.new(5) }

        it 'returns 5 in binary form' do
          subject.must_equal('00000000000000000000000000000101')
        end
      end
    end

    describe '#[]=' do
      describe 'when index is between boundaries' do
        before do
          bit_vector[2] = 1
        end

        it 'stores value in given position' do
          bit_vector.must_equal(BitVector.new(4))
        end
      end
    end

    describe '[]' do
      let(:bit_vector) { BitVector.new(3) }

      it 'gets value from given position' do
        bit_vector[0].must_equal(1)
        bit_vector[1].must_equal(1)
        bit_vector[2].must_equal(0)
      end
    end

    describe '#to_i' do
      subject { bit_vector.to_i }

      before do
        bit_vector[2] = 1
      end

      it 'returns integer representation of vector' do
        subject.must_equal(4)
      end
    end

    describe '.load' do
      subject { BitVector.load(val) }

      describe 'when value is nil' do
        let(:val) { nil }

        it 'initializes array with all elements as FALSE' do
          subject.must_equal(BitVector.new(0))
        end
      end

      describe 'when value is int (4)' do
        let(:val) { 4 }

        it 'initializes array representing 4 in binary' do
          subject.must_equal(BitVector.new(4))
        end
      end
    end

    describe '.dump' do
      let(:bit_vector) { BitVector.new(5) }
      subject { BitVector.dump(bit_vector) }

      it 'dumps de parameter bit vector in its integer form' do
        subject.must_equal(5)
      end
    end
  end
end
