require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe "Cart Discounts" do
  describe "As a Visitor" do
    before :each do
      @merchant_1 = create(:merchant, :with_items)
      @discount_1 = create(:discount, rate: 10, quantity: 2, merchant: @merchant_1)
    end

    describe "When I add enough of a single item" do
      before :each do
        @merchant_2 = create(:merchant, :with_items)

        2.times do
          visit item_path(@merchant_1.items.first)
          click_button 'Add to Cart'
        end

        visit item_path(@merchant_1.items.second)
        click_button 'Add to Cart'

        2.times do
          visit item_path(@merchant_2.items.first)
          click_button 'Add to Cart'
        end

        visit item_path(@merchant_2.items.second)
        click_button 'Add to Cart'
      end

      it 'I see a discount applied to that item' do
        visit '/cart'

        within "#item-#{@merchant_1.items.first.id}" do
          expect(page).to have_content("Discount Applied: #{number_to_percentage(@discount_1.rate, precision: 1)} discount on #{@discount_1.quantity} or more items")
          expect(page).to have_content("Adjusted Item Price: #{number_to_currency(@merchant_1.items.first.price * (1 - (@discount_1.rate / 100)))}")
          expect(page).to have_content("Discounted Subtotal: #{number_to_currency(@merchant_1.items.first.price * (1 - (@discount_1.rate / 100)) * 2)}")
        end
      end

      it 'I do not see a discount applied to other items with same merchant' do
        visit '/cart'

        within "#item-#{@merchant_1.items.second.id}" do
          expect(page).to_not have_content("Discount Applied: ")
          expect(page).to_not have_content("Adjusted Item Price: ")
          expect(page).to_not have_content("Discounted Subtotal: ")
        end
      end

      it 'I do not see a discount applied to other items with different merchant' do
        visit '/cart'

        within "#item-#{@merchant_2.items.first.id}" do
          expect(page).to_not have_content("Discount Applied: ")
          expect(page).to_not have_content("Adjusted Item Price: ")
          expect(page).to_not have_content("Discounted Subtotal: ")
        end

        within "#item-#{@merchant_2.items.second.id}" do
          expect(page).to_not have_content("Discount Applied: ")
          expect(page).to_not have_content("Adjusted Item Price: ")
          expect(page).to_not have_content("Discounted Subtotal: ")
        end
      end

      describe "And there are multiple discounts" do
        before :each do
          @discount_2 = create(:discount, rate: 15, quantity: 2, merchant: @merchant_1)
        end

        it 'I see the greatest discount applied' do
          visit '/cart'

          within "#item-#{@merchant_1.items.first.id}" do
            expect(page).to have_content("Discount Applied: #{number_to_percentage(@discount_2.rate, precision: 1)} discount on #{@discount_2.quantity} or more items")
            expect(page).to have_content("Adjusted Item Price: #{number_to_currency(@merchant_1.items.first.price * (1 - (@discount_2.rate / 100)))}")
            expect(page).to have_content("Discounted Subtotal: #{number_to_currency(@merchant_1.items.first.price * (1 - (@discount_2.rate / 100)) * 2)}")
          end
        end

        it 'I do not see the lesser discounts applied' do
          visit '/cart'

          within "#item-#{@merchant_1.items.first.id}" do
            expect(page).to_not have_content("Discount Applied: #{number_to_percentage(@discount_1.rate, precision: 1)} discount on #{@discount_1.quantity} or more items")
            expect(page).to_not have_content("Adjusted Item Price: #{number_to_currency(@merchant_1.items.first.price * (1 - (@discount_1.rate / 100)))}")
            expect(page).to_not have_content("Discounted Subtotal: #{number_to_currency(@merchant_1.items.first.price * (1 - (@discount_1.rate / 100)) * 2)}")
          end
        end
      end
    end

    describe "When I don't have enough of a single item" do
      before :each do
        visit item_path(@merchant_1.items.second)
        click_button 'Add to Cart'
      end

      it 'I do not see a discount applied to that item' do
        visit '/cart'

        within "#item-#{@merchant_1.items.second.id}" do
          expect(page).to_not have_content("Discount Applied: ")
          expect(page).to_not have_content("Adjusted Item Price: ")
          expect(page).to_not have_content("Discounted Subtotal: ")
        end
      end

      describe "But, I have multiple merchant items" do
        before :each do
          visit item_path(@merchant_1.items.first)
          click_button 'Add to Cart'
        end
        it 'I do not see a discount applied to any item' do
          visit '/cart'

          within "#item-#{@merchant_1.items.first.id}" do
            expect(page).to_not have_content("Discount Applied: ")
            expect(page).to_not have_content("Adjusted Item Price: ")
            expect(page).to_not have_content("Discounted Subtotal: ")
          end

          within "#item-#{@merchant_1.items.second.id}" do
            expect(page).to_not have_content("Discount Applied: ")
            expect(page).to_not have_content("Adjusted Item Price: ")
            expect(page).to_not have_content("Discounted Subtotal: ")
          end
        end
      end
    end
  end
end
