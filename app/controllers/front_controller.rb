class FrontController < ApplicationController

  before_filter :authenticate_user!

  before_filter do
    I18n.locale = current_user.settings(:locals).language
  end

end