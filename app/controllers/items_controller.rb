class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @items = Item.order('created_at DESC')
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :detail, :category_id, :condition_id, :shipping_charge_id, :ship_from_id,
                                 :guideline_id, :price, :image).merge(user_id: current_user.id)
  end
end
