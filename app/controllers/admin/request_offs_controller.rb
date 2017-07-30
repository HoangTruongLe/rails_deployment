# frozen_string_literal: true
require 'zip'

class Admin::RequestOffsController < Admin::ApplicationController
  before_action :set_request_off, only: %i[show edit update accept reject cancel]
  before_action :admin_require, only: %i[accept reject]

  def index
    @request_offs = RequestOff.search(params).deleted_at_as_0.order(time_start: :DESC).
                    paginate(page: params[:page], per_page: 15)
  end

  def show; end

  def accept
    respond_to do |format|
      if @request_off.update(status: 'accepted', status_update_at: Time.zone.now,
                             status_update_by: current_user.id)
        format.html { redirect_to admin_request_offs_path, notice: 'Request off was accepted' }
      end
    end
  end

  def reject
    respond_to do |format|
      if @request_off.update(status: 'rejected', status_update_at: Time.zone.now,
                             status_update_by: current_user.id, comment: params[:comment])
        format.html { redirect_to admin_request_offs_path, notice: 'Request off was rejected' }
      end
    end
  end

  def print
    request_ids = params[:request_ids].split(',')
    @request_offs = RequestOff.where(id: request_ids)
    files = []
    @request_offs.each do |request|
      doc = DocxReplace::Doc.new("#{Rails.root}/public/request_off_template.docx", "#{Rails.root}/public")
      doc.replace('$full_name$', request.user.try(:full_name))
      doc.replace('$gender$', User::TRAMSLATE_VN[request.user.try(:gender).to_sym])
      doc.replace('$birth_date$', request.user.try(:birth_date).strftime("%d/%m/%Y"))
      doc.replace('$position$', User::TRAMSLATE_VN[request.user.try(:position).to_sym])
      doc.replace('$reason$', request.reason)
      doc.replace('$hour_start$', request.time_start.hour)
      doc.replace('$day_start$', request.time_start.day)
      doc.replace('$month_start$', request.time_start.month)
      doc.replace('$year_start$', request.time_start.year)
      doc.replace('$minute_start$', request.time_start.strftime('%M'))
      doc.replace('$hour_end$', request.time_end.hour)
      doc.replace('$day_end$', request.time_end.day)
      doc.replace('$month_end$', request.time_end.month)
      doc.replace('$year_end$', request.time_end.year)
      doc.replace('$minute_end$', request.time_end.strftime('%M'))
      tmp_file = File.new("#{request.id}_#{request.user.first_name}_#{request.time_start.strftime("%d-%m-%Y_%H:%M")}.docx", "w")
      doc.commit(tmp_file.path)
      files << tmp_file
    end
    zip_name = "#{Rails.root}/public/request_off_#{Time.zone.now}.zip"
    File.open("#{zip_name}", 'w') {|file| file.truncate(0) }
    Zip::File.open(zip_name, Zip::File::CREATE) do |zipfile|
      files.each do |file|
        zipfile.add File.basename(file), file.path
      end
    end
    delete_file(files)
    send_file zip_name, type: 'application/zip', disposition: 'attachment'
    FilesCleanupJob.set(wait: 1.minute).perform_later(zip_name)
  end

  def upload
    uploaded_file = params[:import_file]
    File.open(Rails.root.join('public', 'request_off_template.docx'), 'wb') do |file|
      file.write(uploaded_file.read)
    end
    render json: {status: 200}
  end

  private

  def admin_require
    unless current_user.admin?
      redirect_to admin_request_offs_path, notice: 'Ony admin can accept or reject the request offs'
    end
  end

  def set_request_off
    @request_off = RequestOff.find(params[:id])
  end

  def delete_file(files)
    files.each do |file|
      File.delete(file)
    end
  end
end
