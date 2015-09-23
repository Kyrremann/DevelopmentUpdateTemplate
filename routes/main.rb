class DUT < Sinatra::Application
  get '/' do
    site_mode = Configuration.find_by_name("site_mode")
    if site_mode.value == "track"
      @tracks = Track.order("title DESC")
      haml :index_track
    else
      haml :index_cfp
    end
  end
end
