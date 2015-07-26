require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'example.com', '127.0.0.1'
end
