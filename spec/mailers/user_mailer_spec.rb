require "spec_helper"

describe UserMailer do
  let!(:user) { create :user, email: "tdtadeu@gmail.com", reset_password_token:
    "TOKEN" }
  let(:email_validator) { double :email_validator }

  context "Activation email" do
    it "sends the user an email with a link to edit his password" do
      expect(EmailValidator).to receive(:new).with(email: user.email).
        and_return(email_validator)
      expect(email_validator).to receive(:valid?).and_return(true)

      activation_email = UserMailer.activation_email(user).deliver

      expect(ActionMailer::Base.deliveries).to_not be_empty
      expect(activation_email.from).to eq ["no-reply@achievemore.com.br"]
      expect(activation_email.to).to eq ["tdtadeu@gmail.com"]
      expect(activation_email.subject).to eq "Instruções para alterar sua senha"
      expect(activation_email.body.to_s).to include "Olá #{user.name}"
      expect(activation_email.body.to_s).to include "/usuarios/password/edit?reset_password_token=#{user.reset_password_token}"
    end
  end

  context "Password reset email" do
    it "sends the user an email with a link to reset his password" do
      expect(EmailValidator).to receive(:new).with(email: user.email).
        and_return(email_validator)
      expect(email_validator).to receive(:valid?).and_return(true)

      activation_email = UserMailer.reset_password_email(user).deliver

      expect(ActionMailer::Base.deliveries).to_not be_empty
      expect(activation_email.from).to eq ["no-reply@achievemore.com.br"]
      expect(activation_email.to).to eq ["tdtadeu@gmail.com"]
      expect(activation_email.subject).to eq "Instruções para recuperar sua senha"
      expect(activation_email.body.to_s).to include "Olá #{user.name}"
      expect(activation_email.body.to_s).to include "/usuarios/password/edit?reset_password_token=#{user.reset_password_token}"
    end
  end
end
