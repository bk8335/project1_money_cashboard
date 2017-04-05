class CurrencyFormatter
  def self.separate_comma(number)
    number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end
end