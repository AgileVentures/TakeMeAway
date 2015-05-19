module ApplicationHelper

  def clean_datetime datetime
    datetime.to_datetime.strftime("%Y-%m-%d %H:%M:%S")
  rescue
    nil
  end

end
