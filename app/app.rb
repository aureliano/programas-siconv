# encoding: utf-8

class ProgramasSiconv < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers

  get :index do
    render :index
  end
  
  post :index do
    render :index
  end

  get '/sobre' do
    render :sobre
  end
  
  get :feed, :provides => [:rss] do
    @last_days = 10
    @programas = Programa.most_up_to_date_programs :last_days => @last_days
    render 'feed'
  end
  
  error 404 do
    "<h2>Página inexistente.</h2>"
  end
end
