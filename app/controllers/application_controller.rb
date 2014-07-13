class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    I18n.locale = I18nData.country_code(request.location.country) unless user_signed_in?
  end

end
