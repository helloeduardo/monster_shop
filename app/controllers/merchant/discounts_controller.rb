class Merchant::DiscountsController < Merchant::BaseController
  before_action :set_discount, only: [:show, :edit, :update, :destroy]
  before_action :set_merchant, only: [:index, :create]

  def index
    @discounts = @merchant.discounts
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def edit
  end

  def create
    @discount = @merchant.discounts.new(discount_params)

    if @discount.save
      redirect_to merchant_discounts_path, notice: 'Discount was successfully created.'
    else
      generate_flash(@discount)
      render :new
    end
  end

  def update
    if @discount.update(discount_params)
      redirect_to [:merchant, @discount], notice: 'Discount was successfully updated.'
    else
      generate_flash(@discount)
      render :edit
    end
  end

  def destroy
    @discount.destroy
    redirect_to discounts_url, notice: 'Discount was successfully destroyed.'
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def set_merchant
      @merchant = current_user.merchant
    end

    def discount_params
      params.require(:discount).permit(:rate, :quantity, :merchant_id)
    end
end
