require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "should create a user with matching passwords fields" do
      new_user = User.new(name: "Prince", email: "prince@gmail.com", password: "prince123", password_confirmation: "prince123")
      expect{new_user.save}.to_not raise_error
    end

    it "should throw an error when a password doesn't match its confirmation" do
      new_user = User.new(name: "Prince", email: "prince@gmail.com", password: "rushs123", password_confirmation: "prince123")
      expect(new_user).to_not be_valid
      expect(new_user.errors.messages[:password_confirmation]).to eq(["doesn't match Password"])
    end

    it "shouldn't save a user whos password is less than 3 characters" do
      new_user = User.new(name: "Prince", email: "prince@gmail.com", password: "ru", password_confirmation: "ru")
      expect(new_user.save).to eq(false)
      expect(new_user.errors.messages[:password]).to eq(["is too short (minimum is 3 characters)"])
    end

    it "should not save if an email already exists" do
      new_user = User.new(name: "Prince", email: "prince@gmail.com", password: "prince123", password_confirmation: "prince123")
      new_user.save

      new_user2 = User.new(name: "Boris", email: "prince@gmail.com", password: "prince123", password_confirmation: "prince123")
      expect(new_user2.save).to eq(false)
      puts new_user2.errors.messages[:email] 
    end

  end
end

describe '.authenticate_with_credentials' do

  it "should return a matching instance if the user login is authenticated" do
    new_user = User.new(name: "Boris jon", email: "e@gmail.com", password: "rush123", password_confirmation: "rush123")
    new_user.save

    authentication = new_user.authenticate_with_credentials(new_user[:password_digest], new_user[:email])

    expect(new_user).to eq(authentication)

  end

  it "should login despite email case being incorrect" do
    new_user = User.new(name: "Boris jon", email: "eXample@gmail.com", password: "rush123", password_confirmation: "rush123")
    new_user.save

    authentication = new_user.authenticate_with_credentials(new_user[:password_digest], "EXAMPLE@gmail.com")

    expect(new_user).to eq(authentication)

  end

  it "should login despite email whitespace being incorrect" do
    new_user = User.new(name: "Boris jon", email: "eXample@gmail.com", password: "rush123", password_confirmation: "rush123")
    new_user.save

    authentication = new_user.authenticate_with_credentials(new_user[:password_digest], "  EXAMPLE@gmail.com  ")

    expect(new_user).to eq(authentication)

  end

end
