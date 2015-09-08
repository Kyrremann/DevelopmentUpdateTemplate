class DUT < Sinatra::Application
  get '/' do
    haml :index
  end
end
