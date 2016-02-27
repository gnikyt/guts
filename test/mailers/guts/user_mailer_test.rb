class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = guts_users :admin_user
  end
  
  test "should send reset" do
    email = Guts::UserMailer.password_reset(@user).deliver_now
    
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ["from@example.com"], email.from
    assert_equal [@user.email], email.to
    assert_equal "Reset Password", email.subject
    assert_match /\/reset_password\/[0-9a-zA-Z]+/i, email.text_part.body.to_s
    assert_match /\/reset_password\/[0-9a-zA-Z]+/i, email.html_part.body.to_s
  end
end