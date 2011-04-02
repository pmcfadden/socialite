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
    # reload the default url host for all mailers
    config.action_mailer.default_url_options = {:host => AppSettings.smtp_default_url_host } if AppSettings.table_exists?
  end
end
