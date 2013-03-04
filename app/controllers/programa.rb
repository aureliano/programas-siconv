ProgramasSiconv.controllers :programa do
  
  get :programa, :map => '/programa/:id' do
    @programa = Programa.where(:_id => params[:id].to_i).first
    redirect '/404' unless @programa  
    render 'programa/programa'
  end
  
  get :consulta, :map => '/consulta/programas' do
    tags = get_tags_without_stopwords params[:search_params]
    @programas = Programa.with_tags(:skip => skip_value, :limit => DataPage.default_page_size, :tags => tags)
    @total = Programa.count_with_tags(tags)
    
    render 'programa/consulta_programas'
  end
  
  get :disponibilizacoes, :map => '/disponibilizacoes' do
    last_days = params[:dias] ||= 10
    @programas = Programa.most_up_to_date_programs :skip => skip_value, :limit => DataPage.default_page_size, :last_days => last_days.to_i
    @total = Programa.count_most_up_to_date_programs last_days.to_i
    
    render 'programa/novos_programas'
  end
  
  get :estatisticas, :map => '/estatisticas' do
    render 'programa/estatistica/index'
  end
  
  get :estatisticas_programas_por_ano, :map => '/estatisticas/periodo/ano' do
    @chart_data = programas_por_ano_chart_data
    render 'programa/estatistica/programas_por_ano'
  end
  
  get :estatisticas_programas_por_mes, :map => '/estatisticas/periodo/mes' do
    @chart_data = programas_por_mes_chart_data params[:ano].to_i
    render 'programa/estatistica/programas_por_mes'
  end
  
end
