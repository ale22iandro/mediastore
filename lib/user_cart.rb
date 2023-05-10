class UserCart
  attr_reader :total
  def initialize
    @cart = []
  end

  def update(product)
    @cart.push(product)
  end

  def to_h
    @cart.inject(Hash.new(0)) do |total, e|
      total[e] += 1
      total
    end
  end

  def total
    @cart.sum { |product| product.price } # или еще круче @cart.sum(&:price)
  end
end
