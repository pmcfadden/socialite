class AppSettings < RailsSettings::Settings
  validate :validate_setting

  def validate_setting
    # add validation code here
    # self.errors.add(var, "nuh uh")
  end

  def self.update_settings settings
    new_settings = turn_ones_and_zeros_into_booleans settings
    new_settings[:smtp_port] = new_settings[:smtp_port].to_i if new_settings[:smtp_port]
    new_settings.each {|k,v| self[k] = v }
  end

  private
  def self.turn_ones_and_zeros_into_booleans parameters
      parameters.each do |k,v|
        v = v == "1" ? true : v
        v = v == "0" ? false : v
        parameters[k] = v
      end
      parameters
  end
end
