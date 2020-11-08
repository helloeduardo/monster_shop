require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Discount Show Page' do
  describe 'As a merchant employee' do
    before :each do
      @user = create(:merchant_employee)
      @discount = create(:discount, merchant: @user.merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see the discount rate, quantity, and merchant' do
      visit "/merchant/discounts/#{@discount.id}"

      expect(page).to have_content(number_to_percentage(@discount.rate, precision: 1))
      expect(page).to have_content(@discount.quantity)
      expect(page).to have_content(@discount.merchant.name)
    end

    it 'I can click a link to get to a discount edit page' do
      visit "/merchant/discounts/#{@discount.id}"

      click_link 'Edit'

      expect(current_path).to eq("/merchant/discounts/#{@discount.id}/edit")
    end
  end
end
