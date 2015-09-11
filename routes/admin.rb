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
    @track = Track.find_by_title(params["track"])
    @suggestion = Suggestion.find(params["id"])
    @talk = Talk.new("track_id" => @track.id, "time" => params["time"],
                     "title" => @suggestion.title, "description" => @suggestion.description,
                     "speaker" => @suggestion.speaker, "format" => @suggestion.format)
    if @talk.save
      redirect 'admin/suggestions'
    else
      @suggestions = Suggestion.order("created_at DESC")
      @tracks = Track.order("title DESC")
      @errors =  @suggestion.errors
      haml :"admin/suggestions"
    end
    redirect 'admin/suggestions'
  end

  get '/admin/tracks' do
    @tracks = Track.order("title DESC")
    haml :"admin/tracks"
  end

  post '/admin/tracks' do
    @track = Track.new(params["track"])
    if @track.save
      redirect 'admin/tracks'
    else
      @tracks = Track.order("title DESC")
      @errors =  @track.errors
      haml :"admin/tracks"
    end
  end

  get '/admin/talks' do
    @talks = Talk.order("created_at DESC")
    haml :"admin/talks"
  end
end
