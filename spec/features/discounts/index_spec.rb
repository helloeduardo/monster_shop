require 'rails_helper'

RSpec.describe 'Discount Index Page' do
  describe 'As a merchant employee' do
    before :each do
      @user = create(:merchant_employee)
      @discount_1 = create(:discount, merchant: @user.merchant)
      @discount_2 = create(:discount, merchant: @user.merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see a list of all discounts' do
      visit '/merchant/discounts'

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_content(@discount_1.rate)
        expect(page).to have_content(@discount_1.quantity)
      end

      within "#discount-#{@discount_2.id}" do
        expect(page).to have_content(@discount_2.rate)
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
