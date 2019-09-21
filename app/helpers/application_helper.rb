module ApplicationHelper
  include Pagy::Frontend

  def alert_class(key)
    alert_class = case key
                   when 'notice' then "success"
                   when 'alert' then "danger"
                   else key
                   end

  end
end
