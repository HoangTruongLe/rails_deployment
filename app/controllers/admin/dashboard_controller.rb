# frozen_string_literal: true

class Admin::DashboardController < Admin::ApplicationController
  def index
    @request_off_waittings = RequestOff.request_waitting(current_user.id).deleted_at_as_0.paginate(
      page: params[:page], per_page: 20
    )
    @list_user_off_to_day = RequestOff.request_off_to_day
    @list_user_many_day_off = RequestOff.list_user_many_day_off
  end
end
