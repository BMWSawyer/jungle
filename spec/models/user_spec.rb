require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it 'validates that the password and password confirmation match' do
      @user = User.new(:name => "John Smith", :email => "JohnSmith@email.com", :password => "123456", :password_confirmation => "123456")
      
      @user.save
      expect(@user.password).to eq(@user.password_confirmation)
      expect(@user.errors.full_messages).to be_empty
    end

    it 'validates that the password and password confirmation do not match' do
      @user = User.new(:name => "John Smith", :email => "JohnSmith@email.com", :password => "123456", :password_confirmation => "1234567")
      
      @user.save
      
      expect(@user.password).to_not eq(@user.password_confirmation)
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates that the users email must be unique and not case sensitive' do
      @user1 = User.new(:name => "John Smith", :email => "JohnSmith@email.com", :password => "123456", :password_confirmation => "123456")
      @user2 = User.new(:name => "Bill Smith", :email => "johnsmith@email.com", :password => "123456", :password_confirmation => "123456")
      
      @user1.save
      @user2.save
      
      expect(@user2.id).to_not be_present
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'validates that the password is not long enough' do
      @user = User.new(:name => "John Smith", :email => "JohnSmith@email.com", :password => "1234", :password_confirmation => "1234")
      
      @user.save
      
      expect(@user.password.length).to be < 5
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'authenticates a user' do
      @user = User.new(:name => "John Smith", :email => "JohnSmith@email.com", :password => "12345", :password_confirmation => "12345")
      @user.save

      user = User.authenticate_with_credentials('     jOHnSMItH@EmaIl.coM  ', '12345')
      
      expect(user).to_not be_nil
    end
  end
end