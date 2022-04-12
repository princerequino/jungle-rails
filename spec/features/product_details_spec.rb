require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They see product details when clicking from home page" do

    visit root_path

    within first(".product") do
      click_link(match: :first)
    end

    # lets program wait for page load 
    sleep 5

    # save_screenshot

    expect(page).to have_css 'article.product-detail'
    
  end
end
