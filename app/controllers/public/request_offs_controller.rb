
class Public::RequestOffsController < Public::ApplicationController
  before_action :set_request_off, only: [:show, :edit, :update, :destroy, :cancel]
  before_action :check_current_user_invalid, only: [:show, :edit, :update, :cancel, :destroy]
  def index
    @request_offs = RequestOff.where(user_id: current_user.id).order(created_at: :DESC).paginate(page: params[:page], per_page: 15)
  end

  def show
  end

  def new
    @request_off = RequestOff.new
  end

  def edit
  end

  def create
    @request_off = RequestOff.new(request_off_params)
    if @request_off.save
      redirect_to @request_off, notice: 'Request off was successfully created.'
    else
      render :new
    end
  end

  def update
    if @request_off.update(request_off_params)
      redirect_to @request_off, notice: 'Request off was successfully updated.'
    else
      render :edit
    end
  end

  def cancel
    if @request_off.update(status: 'canceled', status_update_at: Time.zone.now,
                           status_update_by: current_user.id)
      redirect_to request_offs_path, notice: 'Request off was successfully canceled.'
    end
  end

  def destroy
    @request_off.destroy
    redirect_to request_offs_url, notice: 'Request off was successfully destroyed.'
  end

  private

    def set_request_off
      @request_off = RequestOff.find(params[:id])
    end

    def request_off_params
      params[:request_off][:user_id] = current_user.id if params[:request_off]
      params.require(:request_off).permit(:time_start, :time_end, :reason, :status, :status_update_at, :status_update_by, :user_id, :total_hours)
    end

    def check_current_user_invalid
      current_req = RequestOff.find_by(id: params[:id]) if params[:id]
      unless current_req.user_id == current_user.id
        redirect_to root_path
      end
    end
end
