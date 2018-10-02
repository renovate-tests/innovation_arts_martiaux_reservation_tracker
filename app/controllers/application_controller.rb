class ApplicationController < ActionController::Base
  before_action :set_locale

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


  def user_is_admin_or_logged_in
    redirect_to new_user_session_path, notice: t('devise.failure.unauthenticated') unless current_user || current_admin
  end


  def user_is_admin
    redirect_to authenticated_user_root_path, notice: t('devise.failure.unauthenticated') unless current_admin
  end


end
