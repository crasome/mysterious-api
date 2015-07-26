require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'example.com'
  c.ignore_localhost = true
  c.default_cassette_options = {
    :match_requests_on => [:method,
      VCR.request_matchers.uri_without_params(:timestamp, :hashkey)]
  }
end
