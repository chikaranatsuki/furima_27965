class OrdersController < ApplicationController
    before_action :select_item, only: [:index, :create]
    before_action :authenticate_user!, only: [:index]
  
    def index
      return redirect_to root_path if current_user.id == select_item.user_id || select_item.item_orders != nil
      # PayFormの作成設定は後ほど行います。
      @item_order = PayForm.new
    end
  
    def create
      @item_order = PayForm.new(item_order_params)
      if @item_order.valid?
        pay_item
        @item_order.save
        return redirect_to root_path
      end
      render 'index'
    end
  
    private
  
    def item_order_params
      params.permit(
        :token,
        :item_id,
        :postal_code,
        :prefecture,
        :city,
        :addresses,
        :building,
        :phone_number
      ).merge(user_id: current_user.id)
    end
  
    def pay_item
      Payjp.api_key = ENV['PAYJP_SK']
      Payjp::Charge.create(
        amount: @item.price,
        card: item_order_params[:token],
        currency: 'jpy'
      )
    end
end
