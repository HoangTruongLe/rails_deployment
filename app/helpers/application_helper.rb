module ApplicationHelper
  def format_date_time(date_time)
    date_time.strftime("%Y/%m/%d %H:%M") if date_time.present?
  end

  def format_date(date)
    date.strftime("%Y/%m/%d") if date.present?
  end

  def format_date_time_vn(date_time)
    date_time.strftime("%d/%m/%Y %H:%M") if date_time.present?
  end

  def format_date_vn(date)
    date.strftime("%d/%m/%Y") if date.present?
  end

  def conver_number_to_date(number)
    if number.present?
      @date = number.to_i/8
      @hour = (number%8).round(1)
      "#{@date} day #{@hour.abs}h"
    end
  end
end
