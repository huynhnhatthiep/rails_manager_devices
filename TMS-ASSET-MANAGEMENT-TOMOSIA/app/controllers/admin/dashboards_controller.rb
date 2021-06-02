class Admin::DashboardsController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @items_broken = Item.items_broken
    @items_stock = Item.items_stock
    @items_out_stock = Item.items_out_stock

    authorize @items_broken
    authorize @items_stock
    authorize @items_out_stock 
  end

  private

  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end
