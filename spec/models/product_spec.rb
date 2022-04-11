require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save successfully when all fields are added' do
      @category = Category.create(name: 'Animals')
      @product = Product.create(name: 'Puppy', price: 100, quantity: 10, category: @category)
      expect(@product).to be_valid
    end

    it 'should return an error if name is nil' do
      @category = Category.create(name: 'Animals')
      @product = Product.create(name: nil, price: 100, quantity: 10, category: @category)
      expect(@product.errors.full_messages).to include ("Name can't be blank")
    end

    it 'should return an error if price is nil' do
      @category = Category.create(name: 'Animals')
      @product = Product.create(name: 'Puppy', price_cents: nil, quantity: 10, category: @category)
      expect(@product.errors.full_messages).to include ("Price can't be blank")
    end

    it 'should return an error if quantity is nil' do
      @category = Category.create(name: 'Animals')
      @product = Product.create(name: 'Puppy', price: 100, quantity: nil, category: @category)
      expect(@product.errors.full_messages).to include ("Quantity can't be blank")
    end

    it 'should return an error if category is nil' do
      @category = Category.create(name: 'Animals')
      @product = Product.create(name: 'Puppy', price: 100, quantity: 10, category: nil)
      expect(@product.errors.full_messages).to include ("Category can't be blank")
    end

  end
end


