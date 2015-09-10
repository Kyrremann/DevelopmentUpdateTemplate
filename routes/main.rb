class DUT < Sinatra::Application
  get '/' do
    site_mode = Configuration.find_by_name("site_mode")
    if site_mode.value == "track"
      haml :track_index
    else
      haml :cfp_index
    end
  end
end
