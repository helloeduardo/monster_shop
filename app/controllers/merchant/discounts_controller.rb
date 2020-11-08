class Merchant::DiscountsController < Merchant::BaseController
  before_action :set_discount, only: [:show, :edit, :update, :destroy]

  # GET /discounts
  def index
    @merchant = current_user.merchant
    @discounts = Discount.all
  end

  # GET /discounts/1
  def show
  end

  # GET /discounts/new
  def new
    @discount = Discount.new
  end

  # GET /discounts/1/edit
  def edit
  end

  # POST /discounts
  def create
    @discount = Discount.new(discount_params)

    if @discount.save
      redirect_to @discount, notice: 'Discount was successfully created.'
    else
      generate_flash(@discount)
      render :new
    end
  end

  # PATCH/PUT /discounts/1
  def update
    if @discount.update(discount_params)
      redirect_to @discount, notice: 'Discount was successfully updated.'
    else
      generate_flash(@discount)
      render :edit
    end
  end

  # DELETE /discounts/1
  def destroy
    @discount.destroy
    redirect_to discounts_url, notice: 'Discount was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discount_params
      params.require(:discount).permit(:rate, :quantity, :merchant_id)
    end
end
