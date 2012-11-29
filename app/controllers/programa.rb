ProgramasSiconv.controllers :programa do
  
  get :programa, :map => '/programa/:codigo' do
    @programa = Programa.first(:cod_programa_siconv => params[:codigo])
    render 'programa/programa'
  end
  
  get :consulta, :map => '/consulta/programas' do
    render 'programa/consulta_programas'
  end
  
  post :consulta, :map => '/consulta/programas' do
    render 'programa/consulta_programas'
  end
  
end
