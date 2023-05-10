# encoding: utf-8

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disc'
require_relative 'lib/user_cart'
require_relative 'lib/product_collection'

collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
collection.sort!(by: :price, order: :asc)
usercart = UserCart.new

loop do
  collection.to_a.each_with_index do |product, index|
    puts "#{index + 1}. #{product}" if product.amount > 0
  end
  puts "0. Выход\n\n"
  puts "Какой товар желаете приобрести?"
  choice = -1

  until choice.between?(0, collection.to_a.size)
    choice = STDIN.gets.to_i
  end

  break if choice == 0
  product = collection.to_a[choice - 1]
  usercart.update(product)
  collection.reserve_product(product)

  puts "У вас в корзине:"

  usercart.to_h.each_with_index do |show_cart, index|
    puts "#{index + 1}. #{show_cart[0]} #{show_cart[1]} шт. " \
    "на сумму #{show_cart[0].price * show_cart[1]} руб."
  end
  puts "Всего товаров на сумму #{usercart.total}"
  puts "*********************************************"
end

puts "Вы купили:"
usercart.to_h.each do |checkout|
  puts "#{checkout[0]}, #{checkout[1]} шт."
end
puts "С Вас — #{usercart.total} руб. Спасибо за покупки!"
