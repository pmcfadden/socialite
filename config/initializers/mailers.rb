Socialite::Application.configure do
  if AppSettings.table_exists?
    require 'app/helpers/application_helper'
    include ApplicationHelper

    setup_exception_notifier

    config.after_initialize do
        setup_action_mailer
    end
  end
end
