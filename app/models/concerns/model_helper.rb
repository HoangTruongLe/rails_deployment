# frozen_string_literal: true

module ModelHelper
  extend ActiveSupport::Concern
  def format_date_time(date_time)
    date_time.strftime('%Y/%m/%d %H:%M') if date_time.present?
  end

  def format_date(date)
    date.strftime('%Y/%m/%d') if date.present?
  end

  def format_date_time_vn(date_time)
    date_time.strftime('%d/%m/%Y %H:%M') if date_time.present?
  end
end
