class DUT < Sinatra::Application
  get '/track/now' do
    haml :now
  end

  get '/track/:track' do | track |
    :track
  end

  get '/track/:track/:id' do | track, id |
    redirect 'track/' + track
  end
end
