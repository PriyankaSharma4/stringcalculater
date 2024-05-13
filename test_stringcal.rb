require 'minitest/autorun'

class StringCalculatorTest < Minitest::Test
  def add(numbers)
    raise ArgumentError, "Input can't be nil" if numbers.nil?

    # Extracting delimiter if specified
    delimiter = ','
    if numbers.start_with?("//")
      delimiter = numbers[2]
      numbers = numbers.sub(/\/\/.\n/, '')
    end

    # Splitting numbers using delimiter and newline
    numbers.split(/#{delimiter}|\n/).map(&:to_i).each do |num|
      raise ArgumentError, "Negative numbers not allowed: #{num}" if num < 0
    end.sum
  end

  def test_empty_string
    assert_equal 0, add("")
  end

  def test_one_number
    assert_equal 1, add("1")
  end

  def test_two_numbers
    assert_equal 6, add("1,5")
  end

  def test_new_line_and_comma_delimiter
    assert_equal 6, add("1\n2,3")
  end

  def test_custom_delimiter
    assert_equal 3, add("//;\n1;2")
  end

  def test_negative_number
    assert_raises(ArgumentError) { add("1,-2,3") }
  end

  def test_multiple_negative_numbers
    assert_raises(ArgumentError) { add("1,-2,-3,4,-5") }
  end

  def test_nil_input
    assert_raises(ArgumentError) { add(nil) }
  end
end
