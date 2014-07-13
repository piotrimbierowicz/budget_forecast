class SettingsForm < FormObject

  attr_accessor :user, :language, :currency

  def initialize(attrs = {})
    super
    self.language ||= user.settings(:locals).language
    self.currency ||= user.settings(:transactions).currency
  end

  def persist!
    user.settings(:locals).language = self.language
    user.settings(:transactions).currency = self.currency
    user.save!
  end

end