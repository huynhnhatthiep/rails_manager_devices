class Admin::EmployeesController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @employees_search = User.employees.paginate(page: params[:page], :per_page => 5)
    @employees = @employees_search.search(params[:term])
    authorize @employees_search
  end

  def show
    @employee = User.find(params[:id])
    @requests_approved_search = @employee.requests.status_approve.paginate(page: params[:page], :per_page => 5)
    @requests_approved = @requests_approved_search.search(params[:term])
    authorize @employee
    authorize @requests_approved
  end

  def new
    @employee = User.new
    authorize @employee
  end

  def create
    @employee = User.new(employee_params)
    authorize @employee
    
    if @employee.save
      flash[:notice] = 'Employee was create.'
      redirect_to admin_employees_path
    else
      render :new
    end
  end


  private

  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end

  def employee_params
    params.require(:user).permit(:name, :email, :phone_number, :password,
                                 :password_confirmation).with_defaults(role: 'user')
  end

  def search_params
    params.permit(:term)
  end
end
