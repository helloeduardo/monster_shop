require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'New Discount Creation' do
  describe 'As a merchant employee' do
    before :each do
      @user = create(:merchant_employee)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can link to a new discount page from discount index' do
      visit 'merchant/discounts'

      click_link 'New Discount'

      expect(current_path).to eq('/merchant/discounts/new')
    end

    it 'I can use the new discount form to create a new discount' do
      visit 'merchant/discounts/new'

      quantity = 5
      rate = 25

      fill_in "Quantity", with: quantity
      fill_in "Rate", with: rate

      click_on "Create Discount"

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_content("Discount was successfully created")

      expect(page).to have_content(quantity)
      expect(page).to have_content(number_to_percentage(rate, precision: 1))
    end

    it 'I can not create a discount with an incomplete form' do
      visit 'merchant/discounts/new'

      quantity = 5

      fill_in "Quantity", with: quantity

      click_on 'Create Discount'

      expect(page).to have_content("rate: [\"can't be blank\", \"is not a number\"]")

      expect(page).to have_button('Create Discount')
    end

    it 'I can not create a discount with invalid data' do
      visit 'merchant/discounts/new'

      quantity = -5
      rate = 250

      fill_in "Quantity", with: quantity
      fill_in "Rate", with: rate

      click_on 'Create Discount'

      expect(page).to have_content("quantity: [\"must be greater than 0\"]")
      expect(page).to have_content("rate: [\"must be less than or equal to 100\"]")

      expect(page).to have_button('Create Discount')
    end
  end
end
