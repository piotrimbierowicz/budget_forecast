class FormObject

  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveRecord::Callbacks
  extend ActiveModel::Naming

  def initialize(args={})
    args.each do |k,v|
      send("#{k}=", v) unless v.nil?
    end
  end

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    # overload
  end

end