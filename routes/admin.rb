class DUT < Sinatra::Application
  before do
    # check for admin role
  end

  get '/admin' do
    @configurations = {}
    Configuration.order("created_at DESC").each do | c |
      @configurations[c.name] = c.value
    end
    haml :"admin/index"
  end

  post '/admin' do
    params["config"].each do | c |
      config = Configuration.find_by_name(c[0])
      config.value = c[1]
      config.save
    end

    redirect 'admin'
  end

  get '/admin/suggestions' do
    @suggestions = Suggestion.order("created_at DESC")
    @tracks = Track.order("title DESC")
    haml :"admin/suggestions"
  end

  post '/admin/suggestions' do
    p params
    redirect 'admin/suggestions'
  end

  get '/admin/tracks' do
    @tracks = Track.order("title DESC")
    haml :"admin/tracks"
  end

  post '/admin/tracks' do
    p params
    redirect 'admin/tracks'
  end
end
