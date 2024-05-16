# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :read_locale

  def read_locale
    I18n.locale = cookies[:locale] || I18n.default_locale
  end

  def set_locale
    locale = params[:locale]
    cookies[:locale] = locale
    redirect_back fallback_location: root_path
  end
end
