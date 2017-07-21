# frozen_string_literal: true
VCR.configure do |c|
  c.cassette_library_dir = "spec/api_response_fixtures"
  c.hook_into :webmock
end
