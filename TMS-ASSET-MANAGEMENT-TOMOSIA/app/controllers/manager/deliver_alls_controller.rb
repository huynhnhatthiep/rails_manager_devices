class Manager::DeliverAllsController < Manager::BaseController
  before_action :authenticate_user!
  before_action :set_deliver, only: [:show, :edit, :update, :destroy]

  def index
    @delivers_list = policy_scope(Deliver).paginate(page: params[:page], :per_page => 8)
    authorize @delivers_list
    @delivers = if params[:term]
      @delivers_list.search(params[:term])
    else
      @delivers = @delivers_list
    end
  end

  private

  def policy_scope(scope)
    super [:manager, scope]
  end

  def authorize(record, query = nil)
    super [:manager, record], query
  end
end
