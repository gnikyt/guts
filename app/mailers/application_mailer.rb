# Main mailer for Guts
# @abstract
# @note "from" sender can defined in configuration as `mailer_from`
class ApplicationMailer < ActionMailer::Base
  default from: Guts.configuration.mailer_from || "from@example.com"
  layout "guts/mailer"
end
