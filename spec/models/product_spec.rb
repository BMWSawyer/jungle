require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it 'validates that a product will save' do
      @category = Category.new(:name => "Tech")
      @product = Product.new(:name => "Smartphone", :price => 100000, :quantity => 10, :category => @category)
      
      @product.save
      expect(@product.id).to be_present
      expect(@product.errors.full_messages).to be_empty
    end
    
    it 'validates that a name is not present' do
      @category = Category.new(:name => "Tech")
      @product = Product.new(:name => nil, :price => 100000, :quantity => 10, :category => @category)
      
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
   
    it 'validates that a price is not present' do
      @category = Category.new(:name => "Tech")
      @product = Product.new(:name => "Smartphone", :price => nil, :quantity => 10, :category => @category)
      
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'validates that a quantity is not present' do
      @category = Category.new(:name => "Tech")
      @product = Product.new(:name => "Smartphone", :price => 100000, :quantity => nil, :category => @category)
      
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'validates that a category is not present' do
      @category = Category.new(:name => "Tech")
      @product = Product.new(:name => "Smartphone", :price => 100000, :quantity => 10, :category => nil)
      
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
