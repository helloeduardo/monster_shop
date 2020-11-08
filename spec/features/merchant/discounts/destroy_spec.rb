require 'rails_helper'

RSpec.describe 'Destroy Existing Discount' do
  describe 'As a merchant employee' do
    before :each do
      @user = create(:merchant_employee)
      @discount = create(:discount, merchant: @user.merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click link to destroy discount from discount index' do
      visit 'merchant/discounts'

      expect(page).to have_content(number_to_percentage(@discount.rate, precision: 1))
      expect(page).to have_content(@discount.quantity)

      click_link 'Delete'

      expect(current_path).to eq("/merchant/discounts")

      expect(page).to_not have_content(number_to_percentage(@discount.rate, precision: 1))
      expect(page).to_not have_content(@discount.quantity)
    end

    it 'I can click link to destroy discount from discount show page' do
      visit "/merchant/discounts/#{@discount.id}"

      expect(page).to have_content(number_to_percentage(@discount.rate, precision: 1))
      expect(page).to have_content(@discount.quantity)

      click_link 'Delete'

      expect(current_path).to eq("/merchant/discounts")

      expect(page).to_not have_content(number_to_percentage(@discount.rate, precision: 1))
      expect(page).to_not have_content(@discount.quantity)
    end
  end
end
