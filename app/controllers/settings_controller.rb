class SettingsController < FrontController

  def index
    @settings_form = SettingsForm.new(user: current_user)
  end

  def update
    data = params[:settings_form]
    data[:user] = current_user
    @settings_form = SettingsForm.new(data)
    if @settings_form.save
      flash[:notice] = I18n.t 'activerecord.update_success.settings'
      redirect_to action: 'index'
    else

    end
  end

end