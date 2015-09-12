class DUT < Sinatra::Application
  before do
    # check for admin role
  end

  get '/admin' do
    @configurations = {}
    Configuration.order("created_at DESC").each do | c |
      @configurations[c.name] = c.value
    end
    @events = Event.order("created_at DESC")
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

  get '/admin/events' do
    @events = Event.order("title DESC")
    haml :"admin/events"
  end

  post '/admin/events' do
    @event = Event.new(params["event"])
    if @event.save
      redirect 'admin/events'
    else
      @events = Event.order("title DESC")
      @errors = @event.errors
      haml :"admin/events"
    end
  end

  get '/admin/suggestions' do
    event = Configuration.find_by_name("event")
    @suggestions = Suggestion.where("event_id = ?", event.value).order("title DESC")
    @tracks = Track.order("title DESC")
    haml :"admin/suggestions"
  end

  post '/admin/suggestions' do
    @suggestion = Suggestion.find(params["id"])
    @talk = Talk.new("event_id" => @suggestion.event_id, "time" => params["time"],
                     "title" => @suggestion.title, "description" => @suggestion.description,
                     "speaker" => @suggestion.speaker, "format" => @suggestion.format,
                     "track" => params["track"])
    if @talk.save
      redirect 'admin/suggestions'
    # else
      # @suggestions = Suggestion.order("created_at DESC")
      # @tracks = Track.order("title DESC")
      # @errors =  @suggestion.errors
      # haml :"admin/suggestions"
    end
    redirect 'admin/suggestions'
  end

  get '/admin/tracks' do
    @tracks = Track.order("title DESC")
    haml :"admin/tracks"
  end

  post '/admin/tracks' do
    @track = Track.new(params["track"])
    @track.save
    redirect 'admin/tracks'
  end

  get '/admin/talks' do
    event = Configuration.find_by_name("event")
    @talks = Talk.where("event_id = ?", event.value).order("title DESC")
    haml :"admin/talks"
  end
end
