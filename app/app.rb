# encoding: utf-8

class ProgramasSiconv < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers

  get :index do
    render :index
  end

  get '/sobre' do
    render :sobre
  end
  
  error 404 do
    "<h2>Página inexistente.</h2>"
  end
end
