require 'minitest/autorun'
require 'minitest/spec'
require 'bitvector'

module BitVector
  describe BitVector do
    let(:number) { 0 }
    let(:bit_vector) { BitVector.new(number) }

    describe "#to_s" do
      subject { bit_vector.to_s }

      describe 'with empty vector' do
        let(:bit_vector) { BitVector.new }

        it 'returns all zeros vector' do
          subject.must_equal('00000000000000000000000000000000')
        end
      end

      describe 'with value 5' do
        let(:number) { 5 }

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

        it "sets value at given position" do
          bit_vector.must_equal BitVector.new(4)
        end
      end

      describe "with a too large index" do
        let(:index) { bit_vector.size + 1 }

        it "raises" do
          lambda { bit_vector[index] = 1 }.must_raise(ArgumentError)
        end
      end

      describe "with a bit set" do
        let(:number) { 0b100 }

        subject { bit_vector[2] }

        before do
          bit_vector[2] = 0
        end

        it "clears bit" do
          subject.must_equal 0
        end
      end
    end

    describe '[]' do
      let(:number) { 3 }

      it "returns values at given positions" do
        bit_vector[0].must_equal 1
        bit_vector[1].must_equal 1
        bit_vector[2].must_equal 0
      end

      describe "with a too large index" do
        let(:index) { bit_vector.size + 1 }

        it "raises" do
          lambda { bit_vector[index] }.must_raise(ArgumentError)
        end
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

    describe "#size" do
      subject { bit_vector.size }

      it "returns the default size" do
        subject.must_equal 32
      end
    end

    describe "#==" do
      let(:other_number) { bit_vector.number }
      let(:other_size) { bit_vector.size }
      let(:other) { BitVector.new other_number, other_size }

      subject { bit_vector == other }

      describe "with same number and size" do
        it "returns true" do
          assert subject
        end
      end

      describe "with different number and same size" do
        let(:other_number) { bit_vector.number + 1 }

        it "returns false" do
          refute subject
        end
      end

      describe "with same number and different size" do
        let(:other_size) { bit_vector.size + 1 }

        it "returns false" do
          refute subject
        end
      end

      describe "with different number and different size" do
        let(:other_number) { bit_vector.number + 1 }
        let(:other_size) { bit_vector.size + 1 }

        it "returns false" do
          refute subject
        end
      end
    end

    describe "with a size argument" do
      let(:size) { 48 }
      let(:bit_vector) { BitVector.new(number, size) }

      describe "#initialize" do
        describe "with a too large number" do
          let(:number) { 2 ** size }

          it "raises" do
            lambda { bit_vector }.must_raise(ArgumentError)
          end
        end
      end

      describe "#size" do
        subject { bit_vector.size }

        it "return the size" do
          subject.must_equal size
        end
      end

      describe "#to_s" do
        subject { bit_vector.to_s }

        it "returns a formatted string" do
          subject.must_equal "000000000000000000000000000000000000000000000000"
        end
      end
    end

    describe '.load' do
      subject { BitVector.load(value) }

      describe 'when value is nil' do
        let(:value) { nil }

        it 'initializes array with all elements as FALSE' do
          subject.must_equal(BitVector.new(0))
        end
      end

      describe "when value is blank" do
        let(:value) { "" }

        it "initializes vector to 0" do
          subject.must_equal(BitVector.new(0))
        end
      end

      describe 'when value is int (4)' do
        let(:value) { 4 }

        it 'initializes array representing 4 in binary' do
          subject.must_equal(BitVector.new(4))
        end
      end
    end

    describe '.dump' do
      let(:number) { 5 }

      subject { BitVector.dump(bit_vector) }

      it 'dumps de parameter bit vector in its integer form' do
        subject.must_equal(5)
      end
    end
  end
end
