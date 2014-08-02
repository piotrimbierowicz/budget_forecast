class TaxTypesController < FrontController

  def index
    @tax_types = current_user.tax_types.all
  end

  def new
    @tax_type = TaxType.new
  end

  def show
    @tax_type = current_user.tax_types.find(params[:id])
  end

  def update
    @tax_type = current_user.tax_types.find(params[:id])
    if @tax_type.update_attributes(params.permit(:tax_type).require(:name, :percent))
      I18n.t 'activerecord.update_success.tax_type'
      render action: :index
    else
      I18n.t 'activerecord.update_fail.tax_type'
      render action: :index
    end
  end

  def create
    @tax_type = TaxType.new(params.permit(:tax_type).require(:name, :percent))
    @tax_type.user_id = current_user.id
    if @tax_type.save
      I18n.t 'activerecord.create_success.tax_type'
      render action: :index
    else
      I18n.t 'activerecord.create_fail.tax_type'
      render action: :index
    end
  end

end