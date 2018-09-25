module ApplicationHelper
  def alternate_locales
    I18n.available_locales.map {|l|
      yield(l)
    }.join.html_safe
  end

  def get_week_day(a_day)
    puts a_day
    days_list = []
    Date::DAYNAMES.each do |day|
      days_list << day
    end
    days_list[a_day]
  end

end
