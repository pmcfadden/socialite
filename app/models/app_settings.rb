class AppSettings < RailsSettings::Settings
  validate :validate_setting

  def validate_setting
    # add validation code here
    # self.errors.add(var, "nuh uh")
  end

  def self.update_settings hash
    hash.each {|k,v| self[k] = v }
  end
end
