class AppSettings < RailsSettings::Settings
  validate :validate_setting

  def self.all_including_defaults
    AppSettings.all.merge(AppSettings.defaults)
  end

  def validate_setting
    # add validation code here
    # self.errors.add(var, "nuh uh")
  end

  def self.basic_settings
    self.all_including_defaults.select do |s|
      ['smtp_authentication_username', 'smtp_authentication_password', 'confirm_email_on_registration'].include? s[0] 
    end
  end

  def self.advanced_settings
    advanced = self.all_including_defaults
    self.basic_settings.each do |s|
      advanced.delete(s[0])
    end
    advanced
  end

  def self.update_settings hash
    hash.each {|k,v| self[k] = v }
  end
end
