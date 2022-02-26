class Sendgrid::Recipient
  attr_reader :id, :errors
  attr_accessor :email, :first_name, :last_name

  def initialize
    @api = ::SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    @errors = nil
    reset_properties
  end

  # find a single user
  # @param [String] field name
  # @param [String] field value
  # @return [Hash, nil]
  def find_by(field, value)
    user = nil
    data = { conditions: [{ and_or: "", field: field, value: value, operator: "eq" }] }
    response = @api.client.contactdb.recipients.search.post(request_body: data)
    if response.status_code == "200"
      user = JSON.parse(response.body)["recipients"]&.first
      if user
        @id = user["id"]
        @email = user["email"]
        @first_name = user["first_name"]
        @last_name = user["last_name"]
      end
    else
      reset_properties
      @errors = { status: response.status_code, body: JSON.parse(response.body)["errors"] }
    end
    user
  end

  # Create a user and return the id
  # @param [Hash] email
  # @return [String, void] user id
  def create(data)
    if !data || !data.is_a?(Hash) || data[:email].nil? || data[:email].empty?
      reset_properties
      if data.nil? || !data.is_a?(Hash)
        @errors = { status: "400", body: [{ "message" => "request body is invalid" }] }
      else
        @errors = { status: "400", body: [{ "message" => "Type of provided email is invalid, email must be a non empty string" }] }
      end
    else
      return @id if @id && @email == data[:email]
      self.find_by("email", data[:email])
      if @id.nil?
        @errors = nil
        request_data = [data]
        response = @api.client.contactdb.recipients.post(request_body: request_data)
        if response.status_code == "201"
          @id = JSON.parse(response.body)["persisted_recipients"]&.first
          @email = data[:email] if data[:email]
          @first_name = data[:first_name] if data[:first_name]
          @last_name = data[:last_name] if data[:last_name]
        else
          reset_properties
          @errors = { status: response.status_code, body: JSON.parse(response.body)["errors"] }
        end
      end
    end
    @id
  end

  private

  def reset_properties
    @id = nil
    @email = nil
    @first_name = nil
    @last_name = nil
  end
end
