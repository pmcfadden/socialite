namespace :production do
  def in_production &block
    old_environment = Rails.env
    Rails.env = 'production'
    yield
    Rails.env = old_environment
  end

  namespace :setup do
    desc 'Creates an administrator user in production'
    task :admin, [:username, :password] => 'db:create' do |t, args|
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

        puts "this task will create an admin user with username of #{username} and password #{password}"
      end
    end
  end

  desc 'Creates a blank production database'
  namespace :db do
    task :create do
      in_production do
        puts "this task will create a blank production database"
      end
    end
  end
end
