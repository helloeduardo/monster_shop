require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Discount Index Page' do
  describe 'As a merchant employee' do
    before :each do
      # @user = create(:merchant_employee)
      # @discount_1 = create(:discount, merchant: @user.merchant)
      # @discount_2 = create(:discount, merchant: @user.merchant)
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      # @merchant = create(:merchant, :with_employee, :with_discounts, discounts: 2)
      # @discount_1 = @merchant.discounts.first
      # @discount_2 = @merchant.discounts.second
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant.users.first)

      @user = create(:merchant_employee, :with_discounts)
      @discount_1 = @user.discounts.first
      @discount_2 = @user.discounts.second
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see a list of all discounts' do
      visit '/merchant/discounts'

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_content(number_to_percentage(@discount_1.rate, precision: 1))
        expect(page).to have_content(@discount_1.quantity)
      end

      within "#discount-#{@discount_2.id}" do
        expect(page).to have_content(number_to_percentage(@discount_2.rate, precision: 1))
        expect(page).to have_content(@discount_2.quantity)
      end
    end

    it 'I can click on link to get to the discount show page' do
      visit '/merchant/discounts'

      within "#discount-#{@discount_1.id}" do
        click_link "Show"
      end

      expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")
    end
  end
end
