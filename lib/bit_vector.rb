require "bit_vector/version"

module BitVector
  class BitVector
    SIZE = 32

    attr_reader :number

    # Returns new bit vector initialized to optional number.
    def initialize(number = 0)
      @number = number
    end

    # Returns a string representation.
    def to_s
      "%0#{SIZE}b" % number
    end

    # Returns an integer representation.
    alias_method :to_i, :number

    # Sets the element at index.
    def []=(index, value)
      mask = 1 << index
      @number = value == 0 ? number & mask : number | mask
    end

    # Returns the element at index.
    def [](index)
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
    # their numbers are equal.
    def ==(other)
      number == other.number
    end
  end
end
