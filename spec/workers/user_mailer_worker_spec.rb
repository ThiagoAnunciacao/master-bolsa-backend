require "spec_helper"

describe UserMailerWorker do
  let(:user) { double :user, id: 1 }
  let(:activation_email) { double :activation_email }

  it "sends an email to the user" do
    expect(User).to receive(:find).with(1).and_return(user)
    expect(UserMailer).to receive(:message).with(user).
      and_return(activation_email)
    expect(activation_email).to receive(:deliver)

    described_class.new.perform(1, :message)
  end
end
