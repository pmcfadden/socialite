Socialite::Application.config.middleware.use ExceptionNotifier,
      :email_prefix => "[Whatever] ",
      :sender_address => %{"notifier" <notifier@example.com>},
      :exception_recipients => %w{matthieutc@gmail.com}

