class Employee::RequestsController < Employee::BaseController
  before_action :authenticate_user!
  before_action :default_request, only: [:show, :change_select]
   
  def index
    user = User.find_by(id: current_user.id)
    @requests_list = user.requests.paginate(page: params[:page], :per_page => 5)
    @requests = @requests_list.search(params[:term])
  end
  
  def show;end
  
  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.build(request_params)
    @item_request = Item.find_by(id: request_params[:item_id])
    
    if @item_request.request.nil?
      request_set
    elsif @item_request.request.status != 'pending'
      check_deliver
    else
      flash[:error] = 'Request for this item is pending'
      render :new
    end
  end

  def request_set
    if @request.save
      notifier = Slack::Notifier.new Request::WEBHOOK_URL
      notifier.post text:"CREATE REQUEST\n User Name: #{current_user.name}\n Type Request: #{@request.type_request}\n  Devices: #{@request.item.name}\n Reason: #{@request.reason} "

      flash[:notice] = 'This user was saved successfully'
      redirect_to employee_requests_path 
    else 
      render :new
    end
  end

  def check_deliver
    if !@item_request.request.deliver.nil?
      if @item_request.request.deliver.status == 'finish' && @item_request.status == 'out_stock'
        request_set
      else
        flash[:error] = 'Request for this item process '
        render :new
      end
    elsif @item_request.request.status == 'reject'
      request_set
    end
  end

  def change_select
    if params[:type_request] == 'Break' || params[:type_request] == 'Restore'
      @items = current_user.items.where(status: 'out_stock').uniq

      respond_to do |format|
        format.js {}
      end
    else
      @items = Item.items_stock
      
      respond_to do |format|
        format.js {}
      end
    end
  end

  private

  def default_request
    @user = User.find_by(id: current_user.id)
    @requests = @user.requests
  end

  def request_params
    params.require(:request).permit(:item_id, :type_request, :start_date, :end_date, :reason, :status).with_defaults(status: 'pending')
  end
end
