class CustomerinfosController < ApplicationController
  before_action :authenticate_user!, expect: :index
  before_action :move_to_index, only: :create
  before_action :same_user, only: [:index, :create]
  before_action :assignment, only: [:index, :create]
  before_action :set_customerinfo

  def index
    @customerinfo_shippinginfo = CustomerinfoShippinginfo.new
  end

  def create
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
  
  def same_user
    redirect_to root_path if current_user.id == @item.user_id
  end
  
  def assignment
    @item = Item.find(params[:item_id])
  end
  
  def set_customerinfo
    redirect_to root_path if @item.customerinfo.present?
  end

end
