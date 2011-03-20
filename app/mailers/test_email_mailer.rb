class TestEmailMailer < ActionMailer::Base
  def send_test_email address

    ActionMailer::Base.smtp_settings = {
                        :address => AppSettings.smtp_address,
                        :port => AppSettings.smtp_port,
                        :domain => AppSettings.smtp_domain,
                        :authentication => AppSettings.smtp_authentication,
                        :user_name => AppSettings.smtp_authentication_username,
                        :password => AppSettings.smtp_authentication_password,
                        :tls => AppSettings.smtp_tls,
                        :enable_starttls_auto => AppSettings.smtp_enable_starttls_auto,
                        }

    logger.info("Sending email using these settings:")
    smtp_settings.each {|k,v| logger.info "#{k} = #{v} as #{v.class}"}

    mail(:to => address,
         :from => "no-reply@#{AppSettings.smtp_domain}",
         :subject => "Test email from Socialite")
  end
end
