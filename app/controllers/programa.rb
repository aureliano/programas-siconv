ProgramasSiconv.controllers :programa do
  
  get :programa, :map => '/programa/:id' do
    @programa = Programa.where(:_id => params[:id].to_i).first
    redirect '/404' unless @programa  
    render 'programa/programa'
  end
  
  get :consulta, :map => '/consulta/programas' do
  puts params[:orgao_superior]
    @programas, @total = Programa.search(:skip => skip_value, :limit => DataPage.default_page_size, :orgao_superior => params[:orgao_superior])
    @orgaos_superiores = Programa.orgaos_superiores

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
  
  get :estatisticas_programas_por_orgao, :map => '/estatisticas/orgao' do
    @chart_data = programas_por_concedente_chart_data params[:concedente]
    render 'programa/estatistica/programas_por_orgao'
  end
  
end
