require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Existing Discount Edit/Update' do
  describe 'As a merchant employee' do
    before :each do
      @user = create(:merchant_employee)
      @discount = create(:discount, merchant: @user.merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can link to an edit discount page from discount index' do
      visit 'merchant/discounts'

      click_link 'Edit'

      expect(current_path).to eq("/merchant/discounts/#{@discount.id}/edit")
    end

    it 'I can link to an edit discount page from discount show page' do
      visit "/merchant/discounts/#{@discount.id}"

      click_link 'Edit'

      expect(current_path).to eq("/merchant/discounts/#{@discount.id}/edit")
    end

    it 'I can use the edit discount form to update a discount' do
      visit "/merchant/discounts/#{@discount.id}/edit"

      quantity = 5
      rate = 25

      fill_in "Quantity", with: quantity
      fill_in "Rate", with: rate

      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts/#{@discount.id}")

      expect(page).to have_content("Discount was successfully updated")
      expect(page).to have_content(quantity)
      expect(page).to have_content(number_to_percentage(rate, precision: 1))
    end

    it 'I can not update a discount with an incomplete form' do
      visit "/merchant/discounts/#{@discount.id}/edit"

      quantity = 5
      rate = ""

      fill_in "Quantity", with: quantity
      fill_in "Rate", with: rate

      click_on 'Update Discount'

      expect(page).to have_content("rate: [\"can't be blank\", \"is not a number\"]")

      expect(page).to have_button('Update Discount')
    end

    it 'I can not update a discount with invalid data' do
      visit "/merchant/discounts/#{@discount.id}/edit"

      quantity = -5
      rate = 250

      fill_in "Quantity", with: quantity
      fill_in "Rate", with: rate

      click_on 'Update Discount'

      expect(page).to have_content("quantity: [\"must be greater than 0\"]")
      expect(page).to have_content("rate: [\"must be less than or equal to 100\"]")

      expect(page).to have_button('Update Discount')
    end
  end
end
