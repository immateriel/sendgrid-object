class Sendgrid::Recipient
  attr_reader :user

  def initialize
    @api = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    @user = nil
  end

  # find a user
  # @param [String] field name
  # @param [String] field value
  # @return [Hash]
  def find_by(field, value)
    data = { conditions: [{ and_or: "", field: field, value: value, operator: "eq" }] }
    response = @api.client.contactdb.recipients.search.post(request_body: data)
    @user = JSON.parse(response.body)["recipients"]&.first
  end

  # Create a user and return the id
  # @param [String] email
  # @return [String, void] user id
  def create(email)
    return @user["id"] if @user && @user["email"] == email
    if email.present? && existing_user = self.find_by("email", email)
      @user = existing_user
      return @user["id"]
    elsif email.present?
      data = [{ email: email }]
      response = @api.client.contactdb.recipients.post(request_body: data)
      JSON.parse(response.body)["persisted_recipients"]&.first
    end
  end
end
