require "benchmark"
require "bundler/setup"
require "bitvector"

N = 100_000

def sample
  @sample ||= BitVector::BitVector.new
end

Benchmark.bmbm do |x|
  x.report "Initialize vector" do
    N.times do
      BitVector::BitVector.new
    end
  end

  x.report "Load vector" do
    N.times do
      BitVector::BitVector.load "00000000000000000000000000000000"
    end
  end

  x.report "Dump vector" do
    N.times do
      BitVector::BitVector.dump sample
    end
  end

  x.report "Set at index" do
    N.times do
      sample[16] = 1
    end
  end

  x.report "Clear at index" do
    N.times do
      sample[16] = 0
    end
  end

  x.report "Get at index" do
    N.times do
      sample[16]
    end
  end
end
