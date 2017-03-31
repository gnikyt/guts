# Allow for testing policies
# From http://stackoverflow.com/a/30754295
class PolicyTest < ActiveSupport::TestCase
  def permit(current_user, record, action)
    self
      .class
      .to_s
      .gsub(/Test/, '')
      .constantize
      .new(current_user, record)
      .public_send("#{action.to_s}?")
  end

  def forbid(current_user, record, action)
    !permit(current_user, record, action)
  end

  def policy_permit(object, method)
    permit(
      object,
      self.class.to_s.gsub(/PolicyTest/, '').constantize,
      method
    )
  end
end
