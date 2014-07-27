require "bit_vector/version"

module BitVector
  class BitVector
    VECTOR_LAST_INDEX = 31

    # Returns new bit vector initialized to optional number.
    def initialize(number = 0)
      @array = []
      VECTOR_LAST_INDEX.downto(0) do |i|
        @array << number[i]
      end
    end

    # Returns a string representation.
    def to_s
      @array.join('')
    end

    # Returns an integer representation.
    def to_i
      to_s.to_i(2)
    end

    # Sets the element at index.
    def []=(index, value)
      array[VECTOR_LAST_INDEX - index] = value
    end

    # Returns the element at index.
    def [](index)
      array[VECTOR_LAST_INDEX - index]
    end

    # Loads vector from value.
    def self.load(value)
      new(value.to_i)
    end

    # Dumps vector to value.
    def self.dump(vector)
      vector.to_i
    end

    # Returns true if equal to other vector. Two vectors are considered equal if
    # their arrays are equal.
    def ==(other)
      array == other.array
    end

    protected

    attr_reader :array
  end
end
