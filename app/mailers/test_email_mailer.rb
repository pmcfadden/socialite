class TestEmailMailer < ActionMailer::Base
  def send_test_email address

    logger.info("Sending email using these settings:")
    smtp_settings.each {|k,v| logger.info "#{k} = #{v} as #{v.class}"}

    mail(:to => address,
         :from => "no-reply@#{AppSettings.smtp_domain}",
         :subject => "Test email from Socialite")
  end
end
