class DUT < Sinatra::Application
  get '/cfp' do
    haml :cfp
  end

  post '/cfp' do
    @suggestion = Suggestion.new(params[:suggestion])
    if @suggestion.save
      redirect 'cfp/suggestions'
    else
      haml :cfp
    end
  end

  get '/cfp/suggestions' do
    @suggestions = Suggestion.order("created_at DESC")
    haml :cfpsuggestions
  end
end
