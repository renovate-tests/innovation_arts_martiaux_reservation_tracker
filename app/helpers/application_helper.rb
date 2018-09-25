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

  def get_latest_belt_color(a_student)
    belt_query_sql = "select b.color from graduations g left join belts b on g.belt_id = b.id where g.student_id = #{a_student} order by graduation_date desc limit 1"
    query_results = ActiveRecord::Base.connection.execute(belt_query_sql).values[0]
    unless query_results.nil?
      query_results[0]
    end
  end

end
