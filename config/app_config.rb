use Rack::Session::Cookie, :secret => 'super_secret_key_that_should_be_set_in_a_env_variable'

unless CLOUDANT_URL = ENV['CLOUDANT_URL']
  raise "You must specify the CLOUDANT_URL env variable"
end
