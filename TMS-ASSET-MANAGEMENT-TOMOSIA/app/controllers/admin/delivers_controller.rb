class Admin::DeliversController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @delivers = Deliver.search(params[:term]).paginate(page: params[:items_total], :per_page => 5)
    authorize @delivers
  end

  private

  def policy_scope(scope)
    super [:manager, scope]
  end

  def authorize(record, query = nil)
    super [:manager, record], query
  end

end
