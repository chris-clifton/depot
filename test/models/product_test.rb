require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(options)
    Product.new(title:        options[:title] || 'My book title',
                description:  options[:description] || 'My book description',
                price:        options[:price] || 1,
                image_url:    options[:image_url] || 'mybookimage.jpg')
  end

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title',
                          description: 'The description of my book.',
                          image_url: 'my_book_cover_image.jpg')

    # Test negative number
    product.price = -1
    assert product.invalid?
    assert_equal product.errors[:price], ['must be greater than or equal to 0.01']

    # Test zero
    product.price = 0
    assert product.invalid?
    assert_equal product.errors[:price], ['must be greater than or equal to 0.01']

    # Test happy path
    product.price = 1
    assert product.valid?
    assert product.errors.empty?
  end

  test 'image url' do
    good_urls = %w[fred.gif fred.jpg fred.png FRED.GIF FRED.JPG FRED.PNG]
    bad_urls  = %w[fred.doc fred.gif/more fred.gif.more]

    good_urls.each do |url|
      assert new_product(image_url: url).valid?, "#{url} should be valid"
    end

    bad_urls.each do |url|
      assert new_product(image_url: url).invalid?, "#{url} shouldn't be valid"
    end
  end

  test 'product is not valid without a unique title' do
    product = new_product(title: products(:ruby).title)
    assert product.invalid?
    assert_equal product.errors[:title], ['has already been taken']
  end

  test 'product is not valid without a long enough name' do
    product = new_product(title: 'too short')
    assert product.invalid?
    assert_equal product.errors[:title], ['10 characters is the minimum allowed']
  end
end
