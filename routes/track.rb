class DUT < Sinatra::Application
  get '/track/now' do
    haml :now
  end

  get '/track/:track' do | track |
    @track = Track.find_by_title(track)
    @tracks = Track.order("title DESC")
    @talks = Talk.where("track_id = ?", @track.id)
    haml :"track/track"
  end

  get '/track/:track/:id' do | track, id |
    redirect 'track/' + track
  end
end
