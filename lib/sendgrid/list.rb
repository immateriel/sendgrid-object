class Sendgrid::List
  attr_reader :list

  def initialize
    @api = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    @list = nil
  end

  # find a list
  # @param [Integer] id of the list
  # @return [Hash]
  def find(id)
    response = @api.client.contactdb.lists._(id).get()
    @list = JSON.parse(response.body)
  end

  # Add a user to a list
  # @param [Integer] id of the user
  # @param [Integer, nil] id of the list
  # @return [void]
  def add_recipient(recipient_id, list_id = nil)
    if recipient_id && (list_id || @list)
      list_id ||= @list["id"]
      @api.client.contactdb.lists._(list_id).recipients._(recipient_id).post()
    end
  end
end
