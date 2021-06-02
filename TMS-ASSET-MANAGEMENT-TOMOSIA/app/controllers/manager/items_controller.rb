class Manager::ItemsController < Manager::BaseController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_new_item, only: [:new, :create]

  def index
    @item_list = policy_scope(Item).paginate(page: params[:page], :per_page => 8)
    authorize @item_list
    @items = if params[:term]
      @item_list.search(params[:term])
    else
      @items = @item_list
    end

  end

  def show;end

  def edit; end

  def new; end 
  
  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:notice] = 'This user was saved successfully'
      redirect_to manager_items_path 
    else 
      render :new
    end
  end 


  def update
    if @item.update(item_params)
      redirect_to manager_items_path
      flash[:notice] = 'This user was saved successfully'
    else
      render :edit
    end
  end

  private
  
  def set_new_item
    @item = Item.new
    authorize @item
  end

  def policy_scope(scope)
    super [:manager, scope]
  end

  def authorize(record, query = nil)
    super [:manager, record], query
  end

  def set_item
    @item = policy_scope(Item).find_by(id: params[:id])
    authorize @item
  end

  def item_params
    params.require(:item).permit(*policy([:manager, @item|| item]).permitted_attributes)
  end
end
