RSpec.describe Sendgrid::Recipient do
  describe "initialize" do
    it "loads a new recipient object" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      expect { sendgrid_recipient.api }.to raise_error(NoMethodError)
      expect(sendgrid_recipient.email).to be_nil
    end
  end

  describe "find_by" do
    it "returns the recipient" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.find_by("email", "john@doe.com")
      expect(ret).to be_a_kind_of(Hash)
      expect(ret["email"]).to eq("john@doe.com")
      expect(sendgrid_recipient.id).to be_a_kind_of(String)
      expect(sendgrid_recipient.email).to be_a_kind_of(String)
      expect(sendgrid_recipient.email).to eq("john@doe.com")
      expect(sendgrid_recipient.first_name).to be_a_kind_of(String)
      expect(sendgrid_recipient.last_name).to be_a_kind_of(String)
      expect(sendgrid_recipient.errors).to be_nil
    end

    it "returns an error for a non-existent field searched" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.find_by("name", "Doe")
      expect(ret).to be_nil
      expect(sendgrid_recipient.errors[:status]).to eq("400")
      expect(sendgrid_recipient.errors[:body]).to eq([{ "message" => "Field does not exist" }])
      expect(sendgrid_recipient.id).to be_nil
      expect(sendgrid_recipient.email).to be_nil
      expect(sendgrid_recipient.first_name).to be_nil
      expect(sendgrid_recipient.last_name).to be_nil
    end

    it "returns an empty result for a not found user" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.find_by("email", "jane@doe.com")
      expect(ret).to be_nil
      expect(sendgrid_recipient.errors).to be_nil
      expect(sendgrid_recipient.id).to be_nil
      expect(sendgrid_recipient.email).to be_nil
      expect(sendgrid_recipient.first_name).to be_nil
      expect(sendgrid_recipient.last_name).to be_nil
    end

    it "returns an empty result for a not found user with badly formatted email" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.find_by("email", "jane.doe.com")
      expect(ret).to be_nil
      expect(sendgrid_recipient.errors).to be_nil
      expect(sendgrid_recipient.id).to be_nil
      expect(sendgrid_recipient.email).to be_nil
      expect(sendgrid_recipient.first_name).to be_nil
      expect(sendgrid_recipient.last_name).to be_nil
    end
  end

  describe "create" do
    it "creates a user with only an email" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.create({ email: "jane@doe.com" })
      expect(ret).to be_a_kind_of(String)
      expect(sendgrid_recipient.id).to be_a_kind_of(String)
      expect(sendgrid_recipient.email).to eq("jane@doe.com")
      expect(sendgrid_recipient.first_name).to be_nil
      expect(sendgrid_recipient.last_name).to be_nil
      expect(sendgrid_recipient.errors).to be_nil
    end

    it "returns an error with nil data" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.create(nil)
      expect(ret).to be_nil
      expect(sendgrid_recipient.id).to be_nil
      expect(sendgrid_recipient.email).to be_nil
      expect(sendgrid_recipient.first_name).to be_nil
      expect(sendgrid_recipient.last_name).to be_nil
      expect(sendgrid_recipient.errors).to be_a_kind_of(Hash)
      expect(sendgrid_recipient.errors[:status]).to eq("400")
      expect(sendgrid_recipient.errors[:body]).to eq([{ "message" => "request body is invalid" }])
    end

    it "returns an error without an email" do
      sendgrid_recipient = Sendgrid::Recipient.new()
      ret = sendgrid_recipient.create({ name: "Jane Doe" })
      expect(ret).to be_nil
      expect(sendgrid_recipient.id).to be_nil
      expect(sendgrid_recipient.email).to be_nil
      expect(sendgrid_recipient.first_name).to be_nil
      expect(sendgrid_recipient.last_name).to be_nil
      expect(sendgrid_recipient.errors).to be_a_kind_of(Hash)
      expect(sendgrid_recipient.errors[:status]).to eq("400")
      expect(sendgrid_recipient.errors[:body]).to eq([{ "message" => "Type of provided email is invalid, email must be a non empty string" }])
    end
  end
end