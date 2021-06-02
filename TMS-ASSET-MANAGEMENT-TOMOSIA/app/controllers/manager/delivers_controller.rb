class Manager::DeliversController < Manager::BaseController
  before_action :authenticate_user!
  before_action :set_deliver, only: [:show, :edit, :update, :destroy]

  def index
    @delivers_list = policy_scope(Deliver.status_procces).paginate(page: params[:page], :per_page => 8)
    authorize @delivers_list
    @delivers = if params[:term]
      @delivers_list.search(params[:term])
    else
      @delivers = @delivers_list
    end
  end

  def show; end

  def edit ;end 

  def update
    case deliver_params[:status]

    when 'finish'
      case @deliver.request.type_request

      when 'Restore' 
        if @deliver.update(deliver_params.merge(date_deliver: Time.zone.now.to_date))
          @deliver.item.update status: "stock"
          deliver_slack
          redirect_to manager_delivers_path
          flash[:notice] = 'This user was saved successfully'
        else
          render :edit
        end
      when 'Borrow'
        if @deliver.update(deliver_params.merge(date_deliver: Time.zone.now.to_date))
          @deliver.item.update status: "out_stock"
          deliver_slack
          redirect_to manager_delivers_path
          flash[:notice] = 'This user was saved successfully'
        else
          render :edit
        end
      else 'Break'
        if @deliver.update(deliver_params.merge(date_deliver: Time.zone.now.to_date))
          @deliver.item.update status: "broken"
          deliver_slack
          redirect_to manager_delivers_path
          flash[:notice] = 'This user was saved successfully'
        else
          render :edit
        end
      end
    when 'pending'
      if @deliver.update(deliver_params)
        redirect_to manager_delivers_path
        flash[:notice] = 'This user was saved successfully' 
      else
        render :edit
      end
    when 'handling'
      if @deliver.update(deliver_params)
        redirect_to manager_delivers_path
        flash[:notice] = 'This user was saved successfully' 
      else
        render :edit
      end
    else
      render :edit
    end
  end
  def deliver_slack
    notifier = Slack::Notifier.new Request::WEBHOOK_URL
    notifier.post text:"DELIVER FINISH \n User Name: #{current_user.name}\n Type Request: #{@deliver.type_deliver}\n  Devices: #{@deliver.item.name}\n status: #{@deliver.status}\n Note: #{@deliver.note} "
  end

  private

  def policy_scope(scope)
    super [:manager, scope]
  end

  def authorize(record, query = nil)
    super [:manager, record], query
  end

  def set_deliver
    @deliver = policy_scope(Deliver).find_by(id: params[:id])
    authorize  @deliver
  end

  def deliver_params
    params.require(:deliver).permit(*policy([:manager, @deliver|| deliver]).permitted_attributes)
  end
end
