AppSettings.defaults['logo_file'] = 'initial_logo.jpg'
AppSettings.defaults['app_name'] = 'Socialite'
AppSettings.defaults['about_page'] = 'Modify what is displayed here from the admin section.'
AppSettings.defaults['confirm_email_on_registration'] = false
AppSettings.defaults['smtp_address'] = 'smtp.gmail.com'
AppSettings.defaults['smtp_port'] = 587
AppSettings.defaults['smtp_domain'] = 'localhost'
AppSettings.defaults['smtp_authentication'] = 'plain'
AppSettings.defaults['smtp_authentication_username'] = nil
AppSettings.defaults['smtp_authentication_password'] = nil
AppSettings.defaults['smtp_enable_starttls_auto'] = true
AppSettings.defaults['smtp_tls'] = true
AppSettings.defaults['from_email'] = 'no-reply@example.com'

Socialite::Application.configure do
  config.after_initialize do
    if AppSettings.table_exists?
      require 'app/helpers/application_helper'
      include ApplicationHelper
      setup_action_mailer
    end
  end
end
