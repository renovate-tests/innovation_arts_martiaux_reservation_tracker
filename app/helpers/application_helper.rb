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
    query_results.nil? ? t('Blanche') : t(query_results[0])
  end


  def get_months_since_last_graduations(a_student)
    last_promotion_sql = "select graduation_date from graduations where student_id = #{a_student} order by graduation_date desc limit 1"
    @results = ActiveRecord::Base.connection.execute(last_promotion_sql).values[0]
    if @results.nil?
      student_creation_sql = "select created_at from students where id = #{a_student}"
      @results = ActiveRecord::Base.connection.execute(student_creation_sql).values[0]
    end
    @results = Date.parse(@results[0]).upto(Date.today).count.fdiv(30).round(2)
  end

end
