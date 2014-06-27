require 'spec_helper'

describe Customer do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  
  it { should validate_presence_of(:subdomain) }
  it { should validate_uniqueness_of(:subdomain) }

  it { should have_many :users }
  it { should have_one(:ftp_account) }
  
  describe "removing customer" do
    let(:customer) { create(:customer) }

    before do
     customer.destroy
    end

    it { expect(customer.destroyed?).to eq(true) }

    it "does not remove customer from database" do
     expect(Customer.only_deleted.count).to eq(1)
    end
  end
end
