require 'spec_helper'

# for more info see https://github.com/plataformatec/devise/wiki/How-To:-Controllers-and-Views-tests-with-Rails-3-%28and-rspec%29
module ControllerMocking
  include Devise::TestHelpers
  include RSpec::Rails::Mocks

  def mock_submission
    mock_model(Submission).as_null_object
  end

  def mock_user
    user = mock_model(User, {:admin => true, :update_attributes => true, :save => true})
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
    user
  end
end
