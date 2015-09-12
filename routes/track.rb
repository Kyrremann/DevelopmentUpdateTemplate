class DUT < Sinatra::Application
  get '/track/now' do
    haml :now
  end

  get '/track/:track' do | track |
    @tracks = Track.order("title DESC")
    @talks = Talk.where("track = ?", track)
    haml :"track/track"
  end

  post '/comment/:track/:id' do | track, id |
    comment = Comment.new(params["comment"], :talk_id => id)
    comment.save
    redirect 'track/' + track
  end

  post '/ajax/rateit' do
    @rateing
    p params
    {"id"=>"0", "value"=>"0"}.to_json
  end
end
