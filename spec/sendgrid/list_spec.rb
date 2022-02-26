require "spec_helper"

RSpec.describe Sendgrid::List do

  describe "initialize" do
    it "loads a new list object" do
      sendgrid_list = Sendgrid::List.new()
      expect { sendgrid_list.api }.to raise_error(NoMethodError)
      expect(sendgrid_list.id).to be_nil
      expect(sendgrid_list.name).to be_nil
      expect(sendgrid_list.recipient_count).to be_nil
    end
  end

  describe "find" do
    it "retrieves a list by its id" do
      sendgrid_list = Sendgrid::List.new()
      ret = sendgrid_list.find(rand(1..40))
      expect(ret).to be_a_kind_of(Hash)
      expect(sendgrid_list.id).to be_a_kind_of(Integer)
      expect(sendgrid_list.name).to be_a_kind_of(String)
      expect(sendgrid_list.recipient_count).to be_a_kind_of(Integer)
      expect(sendgrid_list.errors).to be_nil
    end

    it "returns an error with a non-existent id" do
      sendgrid_list = Sendgrid::List.new()
      ret = sendgrid_list.find(404) # The id 404 is used to test the not found case
      expect(ret).to be_nil
      expect(sendgrid_list.errors[:status]).to eq("404")
      expect(sendgrid_list.errors[:body]).to eq([{ "message" => "List ID does not exist" }])
      expect(sendgrid_list.id).to be_nil
      expect(sendgrid_list.name).to be_nil
      expect(sendgrid_list.recipient_count).to be_nil
    end

    it "returns an error with a badly formatted id" do
      sendgrid_list = Sendgrid::List.new()
      ret = sendgrid_list.find("Anything")
      expect(ret).to be_nil
      expect(sendgrid_list.errors[:status]).to eq("400")
      expect(sendgrid_list.errors[:body]).to eq([{ "message" => "invalid ID" }])
      expect(sendgrid_list.id).to be_nil
      expect(sendgrid_list.name).to be_nil
      expect(sendgrid_list.recipient_count).to be_nil
    end
  end

  describe "add_recipient" do
    it "adds the recipient to the list with his id" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      sendgrid_recipient.find_by("email", "john@doe.com")
      sendgrid_list = Sendgrid::List.new()
      ret = sendgrid_list.add_recipient(sendgrid_recipient.id, 12846200)
      expect(ret).to be_nil
      expect(sendgrid_list.errors).to be_nil
    end

    it "returns an error with a non-existent list id" do
      recipient = Sendgrid::Recipient.new()
      recipient.find_by("email", "john@doe.com")

      sendgrid_list = Sendgrid::List.new()
      ret = sendgrid_list.add_recipient(recipient.id, 404)
      expect(ret).to be_nil
      expect(sendgrid_list.errors[:status]).to eq("404")
      expect(sendgrid_list.errors[:body]).to eq([{ "message" => "List ID does not exist" }])
    end
  end
end