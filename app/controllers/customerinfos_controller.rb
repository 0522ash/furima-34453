class CustomerinfosController < ApplicationController
  before_action :authenticate_user!, expect: :index
  
  def index
    @item = Item.find(params[:item_id])
    @customerinfo_shippinginfo = CustomerinfoShippinginfo.new
  end

  def create
    @item = Item.find(params[:item_id])
    @customerinfo_shippinginfo = CustomerinfoShippinginfo.new(customerinfo_params)
    if @customerinfo_shippinginfo.valid?
      @customerinfo_shippinginfo.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def customerinfo_params
    params.require(:customerinfo_shippinginfo).permit(:postal_code, :city, :address, :building_name, :phone_number, :customerinfo_id, :ship_from_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
