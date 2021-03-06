namespace :production do
  def in_production &block
    old_environment = Rails.env
    Rails.env = 'production'
    yield
    Rails.env = old_environment
  end

  def initialize_app
    require File.expand_path("../../../config/environment", __FILE__)
  end

  namespace :admin do
    desc 'Creates an administrator user in production'
    task :create, [:username, :password] => 'db:create' do |t, args|
      in_production do
        username = args['username']
        password = args['password']
        example_password = "s3cr3t"

        if username.blank? || password.blank?
          raise "Please specify a username and a password for the initial administrator (e.g. rake setup:admin[admin,#{example_password}])"
        end

        if password == example_password
          raise "Please use a different password than #{example_password} :)"
        end

        puts "Creating an admin user with username of #{username} and password #{password}"
        initialize_app
        admin = User.new :username => username, :password => password, :password_confirmation => password, :email => "admin@localhost.localhost", :confirmed_at => Time.now
        admin.save!
        admin.update_attribute :admin, true
      end
    end
  end

  desc 'Creates a blank production database with the proper schema'
  namespace :db do
    task :create do
      in_production do
        puts "Creating a blank production database"
        Rake::Task['db:create'].invoke
        Rake::Task['db:migrate'].invoke
      end
    end
  end

  desc 'Initializes the production database for first deployment'
  task :initialize, [:admin_username, :admin_password] do |t, args|
    puts "Running the bundler"
    IO.popen('bundle', 'r'){|pipe| puts pipe.read}
    exit("Could not run the bundler. Stopping here.") if $? != 0

    Rake::Task['production:admin:create'].invoke(args['admin_username'], args['admin_password'])
    puts "Your production environment is now ready."
    puts "You can start it by typing:\n\n  thin start -e production\n\n"
  end

end
