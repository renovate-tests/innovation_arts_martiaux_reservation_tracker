class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def export_as_csv(an_active_record_relation_results)
    json = an_active_record_relation_results.all.as_json
    @header = json.first.collect {|k,v| k}.join(',')
    @output = json.collect {|node| "#{node.collect{|k,v| v}.join(',')}\n"}.join
    send_data "#{@header}\n#{@output}"
  end


end
