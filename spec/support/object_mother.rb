class ObjectMother
  def self.create_user username
    options = {:username => username, :email => "#{username}@example.com", :password => "123456", :password_confirmation => "123456"}
    TestLogger.log "creating test user with options = #{options}"
    User.create! options
  end

  def self.create_submission options={}
    options[:title] ||= 'title'
    options[:url] ||= 'example.com'
    options[:description] ||= 'description'
    options[:is_spam] ||= false
    options[:user] ||= create_user("test-user#{Time.now.to_f}")
    TestLogger.log "creating test submission with options = #{options}"
    Submission.create! options
  end
end
