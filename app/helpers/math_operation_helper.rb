# frozen_string_literal: true

module MathOperationHelper
  def multiply(num1, num2)
    return 0 if num1.zero? || num2.zero?

    result = 0
    count = num2.abs

    count.times { result += num1 }

    result = -result if (num1.negative?) ^ (num2.negative?)

    result
  end

  def power(base, exponent)
    return 1 if exponent.zero?
    return 0 if base.zero? && exponent.negative?

    result = 1
    count = exponent.abs

    count.times { result = multiply(result, base) }

    result
  end
end
