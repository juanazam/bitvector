require "bit_vector/version"

module BitVector
  class BitVector
    VECTOR_LAST_INDEX = 31

    def initialize(num = 0)
      @array = []
      VECTOR_LAST_INDEX.downto(0) do |i|
        @array << num[i]
      end
    end

    def to_s
      @array.join('')
    end

    def to_i
      to_s.to_i(2)
    end

    def []=(index, value)
      array[VECTOR_LAST_INDEX - index] = value
    end

    def [](index)
      array[VECTOR_LAST_INDEX - index]
    end

    def self.load(val)
      new(val.to_i)
    end

    def self.dump(bit_vector)
      bit_vector.to_i
    end

    def ==(other_vector)
      array == other_vector.array
    end

    protected

    attr_reader :array
  end
end
