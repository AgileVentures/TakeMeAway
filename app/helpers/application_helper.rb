module ApplicationHelper

  def clean_datetime datetime
    datetime.to_datetime.strftime("%Y-%m-%d %H:%M:%S")
  rescue
    nil
  end

  def clean_time datetime
    datetime.to_datetime.strftime("%H:%M")
  rescue
    nil
  end

end
