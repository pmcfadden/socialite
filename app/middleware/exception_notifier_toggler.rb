require 'action_dispatch'

class ExceptionNotifierToggler

  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    options = env['exception_notifier.options'] ||= {}
    options['disabled'] = !AppSettings.exception_notifier_enabled
    options['exception_recipients'] = AppSettings.exception_notifier_recipient
    options['sender_address'] = "notifier@#{AppSettings.smtp_domain}"
    options['email_prefix'] = "[Error] "
    @app.call(env)
  end
end

