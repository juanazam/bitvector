require "bit_vector/version"

module BitVector
  # Provides a class to represent a bit vector using a number and size.
  class BitVector
    DEFAULT_SIZE = 32

    attr_reader :number, :size

    # Returns new bit vector initialized to optional number and size.
    def initialize(number = 0, size = DEFAULT_SIZE)
      @number, @size = number, size
      raise ArgumentError, "number must be =< #{max_number}" if number > max_number
    end

    # Returns a string representation.
    def to_s
      "%0#{size}b" % number
    end

    # Returns an integer representation.
    alias_method :to_i, :number

    # Sets or clears the bit at index.
    def []=(index, value)
      raise ArgumentError, "index must be < #{size}" if index >= size
      mask = 1 << index
      @number = value == 0 ? number & mask : number | mask
    end

    # Returns the bit at index.
    def [](index)
      raise ArgumentError, "index must be < #{size}" if index >= size
      number[index]
    end

    # Loads vector from value.
    def self.load(value)
      new value.to_i
    end

    # Dumps vector to value.
    def self.dump(vector)
      vector.to_i
    end

    # Returns true if equal to other vector. Two vectors are considered equal if
    # their numbers and sizes are equal.
    def ==(other)
      number == other.number && size == other.size
    end

    private

    def max_number
      2 ** size - 1
    end
  end
end
