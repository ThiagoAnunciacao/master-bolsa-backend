require "spec_helper"

describe CustomersController do
  describe "GET /v1/customers/:id" do
    let(:customer) { create :customer }

    it "returns a customer by id" do
      get "/v1/customers/#{customer.id}"

      json = JSON.parse(last_response.body)
      expect(json.delete("id")).to eq customer.id
      expect(json.delete("name")).to eq customer.name
      expect(json.delete("subdomain")).to eq customer.subdomain
      expect(json.delete("slug")).to eq customer.slug
      expect(json).to be_empty
    end
  end

  describe "PUT /v1/customers/:id" do
    let(:customer) { create :customer }

    it "updates a customer" do
      put "/v1/customers/#{customer.id}", { name: "Novo nome", subdomain: "Novo subdomain"}

      expect(last_response.status).to eq(200)
      json = JSON.parse last_response.body
      expect(json.delete("id")).to eq customer.id
      expect(json.delete("name")).to eq "Novo nome"
      expect(json.delete("subdomain")).to eq "Novo subdomain"
      expect(json.delete("slug")).to eq "novo-nome"
      expect(json).to be_empty
    end

    it "returns an error in case of invalid attribute" do
      put "/v1/customers/#{customer.id}", { name: "" }

      expect(last_response.status).to eq 400
      json = JSON.parse last_response.body
      expect(json.delete("error")).to eq "Invalid customer attributes"
      expect(json).to be_empty
    end
  end

  describe "POST v1/customers" do
    let(:customer) { attributes_for :customer }

    it "creates a customer" do
      post "/v1/customers", { name: customer[:name], subdomain: customer[:subdomain] }

      expect(last_response.status).to eq(201)
      json = JSON.parse last_response.body
      expect(json.delete("id")).to_not be_blank
      expect(json.delete("name")).to eq customer[:name]
      expect(json.delete("subdomain")).to eq customer[:subdomain]
      expect(json.delete("slug")).to eq customer[:name].parameterize
      expect(json).to be_empty
    end

    it "returns an error in case of invalid attributes" do
      post "/v1/customers", { name: "", subdomain: "" }

      expect(last_response.status).to eq 400
      json = JSON.parse last_response.body
      expect(json.delete("error")).to eq "Invalid customer"
      expect(json).to be_empty
    end
  end

  describe "DELETE /v1/customers/:id" do
    let(:customer) { create :customer }

    it "deletes a customer by customer_id and id" do
      expect(Customer).to receive(:find).with(customer.id.to_s).and_return(customer)
      expect(customer).to receive(:destroy).and_return(customer).and_call_original
      delete "/v1/customers/#{customer.id}"

      expect(last_response.status).to eq(200)
      expect(customer.deleted_at).to_not be_nil
    end
  end
end
