class TradeOrdersController < ApplicationController

  def create
  	trade_order = TradeOrder.new(trade_order_params.merge(user: current_user, blank_account: current_user.cny_account))
  	trade_order.save
  	redirect_to user_deals_path, notice: '创建委托订单成功'
  end

  def destroy
    trade_order = TradeOrder.find(params[:id])
    if trade_order
      trade_order.close
      redirect_to user_deals_path, notice: '关闭委托订单成功'
    else
      redirect_to user_deals_path, notice: '关闭委托订单失败'
    end
  end

private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def trade_order_params
    params.require(:trade_order).permit(:coin_account_id, :amount, :ppc, :category, :dark_pool, :delegate_type)
  end
end