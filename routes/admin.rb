class DUT < Sinatra::Application
  before do
    # check for admin role
  end

  get '/admin' do
    haml :admin
  end

  post '/admin' do
    haml :admin
  end
end
