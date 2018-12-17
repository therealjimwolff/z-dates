module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice' then 'success'
    when 'alert'  then 'danger'
    else type
    end
  end

  def alert_icon(type)
    case type
    when 'notice' then 'check'
    when 'success' then 'check'
    when 'info' then 'info_outline'
    when 'alert' then 'error_outline'
    else type
    end
  end
end
