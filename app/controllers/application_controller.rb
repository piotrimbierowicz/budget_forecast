class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    begin
      country_code = I18nData.country_code(request.location.country)
      I18n.locale = I18nData.country_code(request.location.country).downcase.to_sym unless user_signed_in? or country_code.blank?
    rescue
    end
  end

end
