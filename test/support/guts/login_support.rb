# Login a admin user before testing controllers
module ActionController
  class TestCase
    include Guts::SessionConcern

    setup do
      user = guts_users :admin_user
      log_in user
    end
  end
end
