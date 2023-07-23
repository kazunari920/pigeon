# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'wasd.kazunari@gmail.com'
  layout 'mailer'
end
