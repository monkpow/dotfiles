require 'minitest/spec'
require 'minitest/autorun'

def torn_number(num)
  d = num.to_s
  first_half, second_half = d.chars.each_slice(2).map(&:join)
  (first_half.to_i + second_half.to_i) ** 2
end

def is_torn_number(num)
  torn_number(num) == num
end


def torn_number_tryer
  #brute force
  # try all four digit numbers, find the list of int squares
  roots = list_square_roots
  puts roots
end

def number_has_no_repeated_digits(num)
  digitArray = num.to_s.split("")
  digitArray.uniq.length == digitArray.length
end


def list_square_roots
  (1000...9999).map {|num| n = Math.sqrt(num); num if n.to_i == n }.compact
end

def get_squares_with_unique_digits
  list_square_roots.find_all {|num| number_has_no_repeated_digits num }
end


def get_torn_numbers
  get_squares_with_unique_digits.find_all {|num| is_torn_number num }
end


describe 'torn_number' do
  it "sum of first two digits and second two digits squared equals the original number" do
    torn = torn_number(3025)
    torn.must_equal(3025)
  end

  it "each digit must be unique" do
    puts get_torn_numbers
  end

  it "filters non-unique digit series" do
    number_has_no_repeated_digits(1111).must_equal false
    number_has_no_repeated_digits(1234).must_equal true
  end
end


