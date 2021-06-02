class Employee::ProfilesController < Employee::BaseController
  before_action :authenticate_user!
   
  def index
    if current_user.blank?
      @current_user = current_user
    end
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "This user was saved successfully"
      redirect_to root_path
    else 
      redirect_to edit_employee_profile_path
      flash[:notice] = "This user was error"
    end
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :address)
  end

end
