class Admin::RequestsController < Admin::BaseController
  before_action :authenticate_user!
   
  def index
    @requests = Request.status_pending.paginate(page: params[:page], :per_page => 5)
    authorize @requests
  end

  def new
  end

  def edit
    @request = Request.find(params[:id])
    authorize @request
  end

  def create
    
    @request = Request.find(params[:approve][:request_id])
    authorize @request

    @deliver = @request.build_deliver(approve_params)
    authorize @deliver

    if @deliver.save
      notifier = Slack::Notifier.new Request::WEBHOOK_URL
      notifier.post text:"APPROVE\n User Name: #{current_user.name}\n Type Request: #{@request.type_request}\n Devices: #{@request.item.name}\n Reason: #{@request.reason}"
      flash[:notice] = 'Deliver was saved.'
      redirect_to admin_requests_path
    else
      flash[:error] = 'There was an error saving the deliver. Please try again.'
    end
   
    if @request.update(:status => 'approve')
      flash[:notice] = 'Deliver was saved.'
    else
      flash[:error] = 'There was an error saving the request. Please try again.'
    end
  end

  def update
    @request = Request.find(params[:id])
    authorize @request

    if @request.update(reject_params)
      notifier = Slack::Notifier.new Request::WEBHOOK_URL
      notifier.post text:"REJECT\n User Name: #{current_user.name}\n Type Request: #{@request.type_request}\n Devices: #{@request.item.name}\n Reason: #{@request.reason} \n Note: #{@request.note}"
      flash[:notice] = 'Status was updated.'  
      redirect_to admin_requests_path
    else
      flash[:error] = 'There was an error saving the request. Please try again.'
    end

  end

  def requests_rejected
    @requests_rejected = Request.status_reject.paginate(page: params[:page], :per_page => 5)
    authorize @requests_rejected
  end

  private

  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end

  def approve_params
    params.require(:approve).permit(:item_id, :type_deliver, :start_date, :end_date, :reason, :status, :request_id).with_defaults(status: 'pending')
  end

  def reject_params
    params.require(:request).permit(:note,:status).with_defaults(status: 'reject')
  end
end
