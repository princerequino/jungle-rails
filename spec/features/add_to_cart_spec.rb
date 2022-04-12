require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
    # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They come to homepage, add item, and then click on My Cart to find item in cart" do
    # ACT
    visit root_path
    first('.product').find('button').click
    # VERIFY
    expect(page).to have_text 'My Cart (1)'
    # TAKE A PICTURE FOR POSTERITY
    # save_screenshot
  end
end