require 'minitest/autorun'
require 'minitest/spec'
require 'bitvector'

module BitVector
  describe BitVector do
    let(:number) { 0 }
    let(:bit_vector) { BitVector.new number }

    describe "#to_s" do
      subject { bit_vector.to_s }

      describe "for an empty vector" do
        let(:bit_vector) { BitVector.new }

        it "returns all zeros" do
          subject.must_equal("00000000000000000000000000000000")
        end
      end

      describe "with a known number" do
        let(:number) { 0b101 }

        it "returns a formatted string" do
          subject.must_equal("00000000000000000000000000000101")
        end
      end
    end

    describe '#[]=' do
      describe "with a too large index" do
        let(:index) { bit_vector.size }

        it "raises" do
          lambda { bit_vector[index] = 1 }.must_raise(ArgumentError)
        end
      end

      describe "with a bit set" do
        let(:number) { 0b100 }

        subject { bit_vector[2] }

        describe "when set to 0" do
          before do
            bit_vector[2] = 0
          end

          it "clears bit" do
            subject.must_equal 0
          end
        end

        describe "when set to false" do
          before do
            bit_vector[2] = false
          end

          it "clears bit" do
            subject.must_equal 0
          end
        end
      end

      describe "with no bits set" do
        let(:number) { 0b0 }

        subject { bit_vector[0] }

        describe "when set to 1" do
          before do
            bit_vector[0] = 1
          end

          it "sets bit" do
            subject.must_equal 1
          end
        end

        describe "when set to true" do
          before do
            bit_vector[0] = true
          end

          it "sets bit" do
            subject.must_equal 1
          end
        end
      end
    end

    describe '[]' do
      let(:number) { 0b011 }

      it "returns values at given positions" do
        bit_vector[0].must_equal 1
        bit_vector[1].must_equal 1
        bit_vector[2].must_equal 0
      end

      describe "with a too large index" do
        let(:index) { bit_vector.size }

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

    describe "#+" do
      let(:other_size) { bit_vector.size }
      let(:other) { BitVector.new other_number, other_size }

      subject { bit_vector + other }

      describe "with known numbers" do
        let(:number) { 0b101 }
        let(:other_number) { 0b110 }

        it "returns the or'ed number" do
          subject.number.must_equal 0b111
        end
      end
    end

    describe "#-" do
      let(:other_size) { bit_vector.size }
      let(:other) { BitVector.new other_number, other_size }

      subject { bit_vector - other }

      describe "with known numbers" do
        let(:number) { 0b101 }
        let(:other_number) { 0b110 }

        it "returns the and'ed number" do
          subject.number.must_equal 0b100
        end
      end
    end

    describe "#include?" do
      let(:number) { 0b111 }

      subject { bit_vector.include? indexes }

      describe "with included indexes" do
        let(:indexes) { [0, 1] }

        it "returns true" do
          assert subject
        end
      end

      describe "with partially included indexes" do
        let(:indexes) { [0, 1, 3] }

        it "returns false" do
          refute subject
        end
      end

      describe "with excluded indexes" do
        let(:indexes) { [3, 4] }

        it "returns false" do
          refute subject
        end
      end

      describe "with no indexes" do
        let(:indexes) { [] }

        it "returns true" do
          assert subject
        end
      end
    end

    describe "#exclude?" do
      let(:number) { 0b111 }

      subject { bit_vector.exclude? indexes }

      describe "with excluded indexes" do
        let(:indexes) { [3, 4] }

        it "returns true" do
          assert subject
        end
      end

      describe "with partially excluded indexes" do
        let(:indexes) { [3, 4, 0] }

        it "returns false" do
          refute subject
        end
      end

      describe "with included indexes" do
        let(:indexes) { [0, 1] }

        it "returns false" do
          refute subject
        end
      end

      describe "with no indexes" do
        let(:indexes) { [] }

        it "returns true" do
          assert subject
        end
      end
    end

    describe "#hash" do
      let(:other) { BitVector.new other_number }

      subject { bit_vector.hash }

      describe "with the same number" do
        let(:other_number) { number }

        it "is equal" do
          subject.must_equal other.hash
        end
      end

      describe "with a different number" do
        let(:other_number) { number + 1 }

        it "is not equal" do
          subject.wont_equal other.hash
        end
      end

      describe "when used with a hash and known values" do
        let(:hash) do
          {
            BitVector.new(0b100) => 1,
            BitVector.new(0b100) => 2,
            BitVector.new(0b101) => 3
          }
        end

        it "has the right size" do
          hash.size.must_equal 2
        end
      end
    end

    describe ".from_indexes" do
      subject { BitVector.from_indexes indexes }

      describe "with no indexes" do
        let(:indexes) { [] }

        it "returns the zero vector" do
          subject.must_equal BitVector.new(0)
        end
      end

      describe "with known indexes" do
        let(:indexes) { [1, 2] }

        it "returns the expected vector" do
          subject.must_equal BitVector.new(0b110)
        end
      end

      describe "with known, sparse and repeted indexes" do
        let(:indexes) { [0, 2, 4, 4] }

        it "returns the expected vector" do
          subject.must_equal BitVector.new(0b10101)
        end
      end

      describe "with a too large index" do
        let(:indexes) { [1, 2, 48] }

        it "raises" do
          lambda { subject }.must_raise(ArgumentError)
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
