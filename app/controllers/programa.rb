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
  
end
