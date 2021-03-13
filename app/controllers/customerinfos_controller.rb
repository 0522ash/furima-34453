class CustomerinfosController < ApplicationController
  before_action :authenticate_user!, expect: :index

  def index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
    @customerinfo_shippinginfo = CustomerinfoShippinginfo.new
  end

  def create
    @item = Item.find(params[:item_id])
    @customerinfo_shippinginfo = CustomerinfoShippinginfo.new(customerinfo_params)
    if @customerinfo_shippinginfo.valid?
      pay_item
      @customerinfo_shippinginfo.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def customerinfo_params
    params.require(:customerinfo_shippinginfo).permit(:postal_code, :city, :address, :building_name, :phone_number, :customerinfo_id, :ship_from_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: customerinfo_params[:token],
      currency: 'jpy'
    )
  end
end
