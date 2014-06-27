#encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "no-reply@achievemore.com.br"

  def activation_email(user)
    @user = user

    if @user.email.present?
      mail to: @user.email, subject: "Instruções para alterar sua senha" do |format|
        format.html
      end
    end
  end
end
