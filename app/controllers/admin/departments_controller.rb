class Admin::DepartmentsController < Admin::ApplicationController
  before_action :find_department, only: [:edit, :update, :destroy, :show]
  def index
    @departments = Department.all.paginate(page: params[:page], per_page: 20)
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(department_params)
    if @department.save
      redirect_to admin_departments_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to admin_departments_path
    else
      render action: :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to admin_departments_path
  end

  def show
    @users = @department.users.deleted_at_as_0.paginate(:page => params[:page], :per_page => 10)
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end

  def find_department
    @department = Department.find(params[:id])
  end
end
