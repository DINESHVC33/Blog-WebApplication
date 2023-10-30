class SignupMailerJob < ApplicationJob

  queue_as :default

  def perform(user)
    UserMailer.welcome_mail(user).deliver_now
  end
end
