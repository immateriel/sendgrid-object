require "bundler/setup"
require "sendgrid-object"
require 'webmock/rspec'

ENV['SENDGRID_API_KEY']="ThisIsAFakeKey"

RSpec.configure do |config|

  # Used to stub the API calls
  config.before(:each) do

    headers = {
      'Accept'=>'application/json',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>"Bearer #{ENV['SENDGRID_API_KEY']}",
      'Content-Type'=>'application/json',
      'User-Agent'=>'sendgrid/6.6.1;ruby'
    }
    headers_without_content_type = {
      'Accept'=>'application/json',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>"Bearer #{ENV['SENDGRID_API_KEY']}",
      'User-Agent'=>'sendgrid/6.6.1;ruby'
    }

    # Sendgrid::List
    list_found_response = {
      id: rand(1..40),
      name: "Anything",
      recipient_count: rand(1..40)
    }
    list_not_found_response = {
      errors: [ message: "List ID does not exist" ]
    }
    invalid_id_response = {
      errors: [ message: "invalid ID" ]
    }
    stub_request(:get, /https:\/\/api.sendgrid.com\/v\d\/contactdb\/lists\/(?!404$)\d+$/).
      to_return(status: 200, body: list_found_response.to_json, headers: {})

    stub_request(:get, /https:\/\/api.sendgrid.com\/v\d\/contactdb\/lists\/404$/).
      to_return(status: 404, body: list_not_found_response.to_json, headers: {})

    stub_request(:get, /https:\/\/api.sendgrid.com\/v\d\/contactdb\/lists\/(?!404$)\D+$/).
      to_return(status: 400, body: invalid_id_response.to_json, headers: {})

    # Sendgrid::Recipient
    recipient_found_response = {
      recipient_count: 1,
      recipients: [
        { id: "Anything",
          email: "john@doe.com",
          first_name: "John",
          last_name: "Doe" }
      ]
    }
    recipient_not_found_response = {
      recipient_count: 0,
      recipients: []
    }
    not_existing_field_response = {
      errors: [ message: "Field does not exist" ]
    }
    request_body_invalid_response = {
      errors: [ message: "request body is invalid" ]
    }
    created_recipient_response = { new_count: 1, updated_count: 0, error_count: 0, error_indices: [],
                                   unmodified_indices: [], persisted_recipients: ["Anything"], errors: []}
    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/recipients/search").
      with(
        body: "{\"conditions\":[{\"and_or\":\"\",\"field\":\"email\",\"value\":\"john@doe.com\",\"operator\":\"eq\"}]}",
        headers: headers).
      to_return(status: 200, body: recipient_found_response.to_json, headers: {})
    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/recipients/search").
      with(
        body: "{\"conditions\":[{\"and_or\":\"\",\"field\":\"name\",\"value\":\"Doe\",\"operator\":\"eq\"}]}",
        headers: headers).
      to_return(status: 400, body: not_existing_field_response.to_json, headers: {})
    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/recipients/search").
      with(
        body: "{\"conditions\":[{\"and_or\":\"\",\"field\":\"email\",\"value\":\"jane@doe.com\",\"operator\":\"eq\"}]}",
        headers: headers).
      to_return(status: 200, body: recipient_not_found_response.to_json, headers: {})
    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/recipients/search").
      with(
        body: "{\"conditions\":[{\"and_or\":\"\",\"field\":\"email\",\"value\":\"jane.doe.com\",\"operator\":\"eq\"}]}",
        headers: headers).
      to_return(status: 200, body: recipient_not_found_response.to_json, headers: {})
    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/recipients").
      with(
        body: "[{\"email\":\"jane@doe.com\"}]",
        headers: headers).
      to_return(status: 201, body: created_recipient_response.to_json, headers: {})
    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/lists/12846200/recipients/Anything").
      with(
        headers: headers_without_content_type).
      to_return(status: 201, body: "".to_json, headers: {})

    stub_request(:post, "https://api.sendgrid.com/v3/contactdb/lists/404/recipients/Anything").
      with(
        headers: headers_without_content_type).
      to_return(status: 404, body: list_not_found_response.to_json, headers: {})
    stub_request(:delete, "https://api.sendgrid.com/v3/contactdb/recipients/Anything").
      with(
        headers: headers_without_content_type).
      to_return(status: 204, body: nil.to_json, headers: {})
    stub_request(:delete, "https://api.sendgrid.com/v3/contactdb/recipients/400").
      with(
        headers: headers_without_content_type).
      to_return(status: 400, body: invalid_id_response.to_json, headers: {})
    stub_request(:delete, "https://api.sendgrid.com/v3/contactdb/recipients").
      with(
        headers: headers_without_content_type).
      to_return(status: 400, body: request_body_invalid_response.to_json, headers: {})
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
