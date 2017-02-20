require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "features/cassettes"
  c.hook_into :webmock
  c.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  t.tag "@vcr", use_scenario_name: true
end

unless ENV["VCR_OFF"].nil?
  WebMock.allow_net_connect!
  VCR.turn_off!(ignore_cassettes: true)
end
