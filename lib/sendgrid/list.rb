class Sendgrid::List
  attr_reader :id, :recipient_count, :errors
  attr_accessor :name

  def initialize(data = {})
    @api = ::SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    @errors = nil
    reset_properties
    @name ||= data["name"]
  end

  # find a list
  # @param [Integer] id of the list
  # @return [Hash, nil]
  def find(id)
    list = nil
    response = @api.client.contactdb.lists._(id).get()
    if response.status_code == "200"
      list = JSON.parse(response.body)
      @id = list["id"]
      @name = list["name"]
      @recipient_count = list["recipient_count"]
    else
      reset_properties
      @errors = { status: response.status_code, body: JSON.parse(response.body)["errors"] }
    end
    list
  end

  # Add a user to a list
  # @param [Integer] id of the user
  # @param [Integer, nil] id of the list
  # @return [void]
  def add_recipient(recipient_id, list_id = nil)
    if recipient_id && (list_id || @id)
      list_id ||= @id
      response = @api.client.contactdb.lists._(list_id).recipients._(recipient_id).post()
      if response.status_code != "201"
        @errors = { status: response.status_code, body: JSON.parse(response.body)["errors"] }
      end
    end
    nil
  end

  private

    def reset_properties
      @id = nil
      @name = nil
      @recipient_count = nil
    end
end
