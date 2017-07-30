# frozen_string_literal: true

require 'working_hours'
class RequestOff < ApplicationRecord
  include WorkingHours
  include ModelHelper
  extend Enumerize

  belongs_to :user
  validates :time_start, :time_end, :reason, :user_id, :status_update_by, presence: true
  validates :status, inclusion: { in: %w[waiting accepted rejected canceled],
                                  message: '%<value>s is not a valid size' }

  scope :status, ->(status) { where status: status }
  scope :request_waitting, ->(current_id) { where(status: 'waiting', status_update_by: current_id).order(:time_start) }
  scope :request_accepted, -> { where(status: 'accepted') }
  scope :deleted_at_as_0, -> { joins(:user).where('users.deleted_at = 0') }
  scope :request_accepted_and_deleted_at_as_0, -> { where(status: 'accepted').joins(:user).where('users.deleted_at = 0') }

  before_save :calculate_total_hours
  enumerize :status_request, in: %i[waiting accepted rejected canceled]

  after_save :send_notification, :update_remaining_time

  def calculate_total_hours
    if time_start && time_end
      self.total_hours = (time_start.working_time_until(time_end).to_f / 3600).floor(1)
    end
  end

  def self.request_off_to_day
    to_day = Time.zone.now.strftime('%Y/%m/%d')
    list_request_accepted = request_accepted_and_deleted_at_as_0
    result = []
    list_request_accepted.each do |req|
      time_start = req.time_start.strftime('%Y/%m/%d')
      time_end = req.time_end.strftime('%Y/%m/%d')
      if time_start <= to_day && to_day <= time_end
        result << req
      end
    end
    result
  end

  def self.list_user_many_day_off
    list_request = request_accepted_and_deleted_at_as_0.select('sum(total_hours)', :user_id).
                   group(:user_id).order('sum(total_hours) DESC').limit(5)
    result = []
    list_request.each do |req|
      total = RequestOff.request_accepted.where(user_id: req.user_id).pluck(:total_hours).sum
      result << { user_id: req.user_id, total_hours: total }
    end
    result
  end

  def send_notification
    ChatWork.api_key = ENV['API_CHATWORK']
    requester_name = User.find_by(id: user_id).full_name
    requester_chatwork_id = User.find_by(id: user_id).chatwork_id
    assignee_name = User.find_by(id: status_update_by).full_name
    assignee_chatwork_id = User.find_by(id: status_update_by).chatwork_id
    message_body = ''
    if saved_change_to_status? && status == 'accepted'
      message_body = "[To:#{requester_chatwork_id}] #{requester_name}\n"
      message_body += "Your request has been accepted by #{assignee_name}\n"
      message_body += "Detail: #{ENV['REQUEST_MEMBER']}/#{id}"
    end
    if saved_change_to_status? && status == 'rejected'
      message_body = "[To:#{requester_chatwork_id}] #{requester_name}\n"
      message_body += "Your request has been rejected by #{assignee_name}\n"
      message_body += "Reason: #{comment}\n"
      message_body += "Detail: #{ENV['REQUEST_MEMBER']}/#{id}"
    end
    if saved_change_to_id?
      message_body = "[To:#{assignee_chatwork_id}] #{assignee_name}\n"
      message_body += "#{requester_name} has just sent a time-off request!\n"
      message_body += "From: #{format_date_time_vn(time_start)}\n"
      message_body += "To: #{format_date_time_vn(time_end)}\n"
      message_body += "Total time-off: #{total_hours} #{'hour'.pluralize(total_hours)}\n"
      message_body += "Reason: #{reason}\n"
      message_body += "Detail: #{ENV['REQUEST_ADMIN']}/#{id}"
    end

    ChatWork::Message.create room_id: ENV['ROOM_ID'], body: message_body
  end

  def self.search(params)
    conditions = []
    conditions_params(params, conditions)
    if conditions.present?
      query = [conditions.map(&:first).join(' AND '), *conditions.flat_map { |c| c[1..-1] }]
      where(query)
    else
      self
    end
  end

  def self.conditions_params(params, conditions)
    if params[:created_at].present?
      conditions << ['request_offs.created_at::date = ?', params[:created_at]]
    end
    if params[:status].present?
      conditions << ['request_offs.status = ?', params[:status]]
    end
    if params[:status_update_by].present?
      conditions << ['request_offs.status_update_by = ?', params[:status_update_by]]
    end
    if params[:user_id].present?
      conditions << ['request_offs.user_id = ?', params[:user_id]]
    end
    if params[:search].blank?
      self
    end
  end

  def update_remaining_time
    if saved_change_to_status? && status == 'accepted'
      remaining_day = User.find_by(id: user_id).remaining_days_off - total_hours
      User.find_by(id: user_id).update(remaining_days_off: remaining_day)
    end
  end
end
