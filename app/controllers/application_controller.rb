class ApplicationController < ActionController::Base
  before_action :set_locale

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
end
