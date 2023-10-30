class UserMailer < ApplicationMailer
  def welcome_mail(user)
    @user=user
    @greeting = "Hi"

    mail(from:"Blog-App@gmail.com",
         to:@user.email,
         subject: "Sign_up welcome mail"
    )
  end
end
