class DUT < Sinatra::Application
  get '/cfp' do
    p params
    @errors = {}
    haml :"cfp/index"
  end

  post '/cfp' do
    @suggestion = Suggestion.new(params[:suggestion])
    if @suggestion.save
      redirect 'cfp/suggestions'
    else
      p @suggestion.errors.messages
      redirect 'cfp'
    end
  end

  get '/cfp/suggestions' do
    @suggestions = Suggestion.order("created_at DESC")
    haml :"cfp/suggestions"
  end
end
