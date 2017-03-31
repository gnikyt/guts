module Guts
  # Index policy (headless)
  class IndexPolicy < Struct.new(:user, :index)
    # Policy for index method
    # @return [Boolean] allowed or denied
    def index?
      !user.nil?
    end
  end
end
