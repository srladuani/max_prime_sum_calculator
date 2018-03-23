require 'humanize'
require 'prime'

# calculates maximum consecutive prime numbers sum
class MaxPrimeSumCalculator
  
  def initialize(max_limit=1000000)
    @max_limit = max_limit
    @prime_numbers = set_prime_numbers
    @consecutive_primes = []
  end

  
  def get_consecutive_primes
    sum = 0
    max_index = 0
    @prime_numbers.each_with_index do |number,index|
      sum += number
      break if sum > @max_limit
      max_index = index if sum.prime?
    end
    @consecutive_primes = @prime_numbers[0 .. max_index]
  end


  def output
    get_consecutive_primes
    result = ""
    @consecutive_primes.each do |number|
      if @consecutive_primes.last == number
        result += "#{number}"
      else
        result += "#{number} + "
      end
    end
    output = <<-output
      The prime #{@consecutive_primes.sum}, can be written as the sum of #{@consecutive_primes.length.humanize} consecutive primes:
              #{@consecutive_primes.sum} = #{result}
      This is the longest sum of consecutive primes that adds to a prime bellow #{format_humanize(@max_limit)}
    output
    puts output
  end

  private
    def set_prime_numbers
      Prime.each(@max_limit).to_a
    end

    def format_humanize(number)
      number.humanize.gsub(' ','-')
    end
end

class Array
  def sum
    inject { |sum, x| sum + x }
  end
end


prime_calculator = MaxPrimeSumCalculator.new(1000000)
prime_calculator.output

