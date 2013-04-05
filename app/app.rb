# encoding: utf-8

class ProgramasSiconv < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  get :index do
    render :index
  end

  get :sobre do
    render :sobre
  end
  
  get :changelog, :map => '/log/versao/:version' do
    @show_full_log = case params[:version]
      when 'atual' then false
      when 'todas' then 'true'
      else redirect '/404'
    end
    
    render :changelog
  end
  
  get :changelog, :map => '/log/versao/todas' do
    render :changelog
  end
  
  get :feed, :provides => [:rss, :atom] do
    @last_days = 10
    @programas = Programa.most_up_to_date_programs :last_days => @last_days
    render 'feed'
  end
  
  error 404 do
    redirect '/404'
  end
  
  get '/404' do
    html = "<html>\n<head>\n  <title>Página não encontrada</title>\n<head>\n<body>\n  "
    html << image_tag('chuck-norris.jpg', :alt => 'Chuck Norris')
    html << '  <p><b>Chuck Norris disse que a página que você procura não existe. E se ele disse é melhor você acreditar!</b>'
    html << '  <br/><br/><a href="/">Ir para página inicial</a>'
    html << "\n</body>\n</html>"
  end
  
  # Configure smtp mailer
  set :delivery_method, :smtp => { 
    :address              => ENV['EMAIL_SMTP_ADDRESS'],
    :port                 => 587,
    :user_name            => ENV['EMAIL_USER_NAME'],
    :password             => ENV['EMAIL_PASSWORD'],
    :authentication       => :plain,
    :enable_starttls_auto => true
  }
end
