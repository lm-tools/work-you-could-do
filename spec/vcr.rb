require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

unless ENV["VCR_OFF"].nil?
  WebMock.allow_net_connect!
  VCR.turn_off!(ignore_cassettes: true)
end
