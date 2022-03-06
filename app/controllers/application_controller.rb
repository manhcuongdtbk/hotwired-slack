class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = if user_signed_in?
                    current_user.locale
                  else
                    params[:locale] || locale_from_header || I18n.default_locale
                  end
  end

  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/^[a-z]{2}/).first
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name locale])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name locale])
  end
end
