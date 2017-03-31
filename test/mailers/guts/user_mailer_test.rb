class UserMailerTest < ActionMailer::TestCase
  test 'should send reset' do
    user = guts_users :admin_user
    email = Guts::UserMailer.password_reset(user).deliver_now
    
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['from@example.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'Reset Password', email.subject
    assert_match %r{/reset_password\/[0-9a-zA-Z]+}, email.text_part.body.to_s
    assert_match %r{/reset_password\/[0-9a-zA-Z]+}, email.html_part.body.to_s
  end
end
