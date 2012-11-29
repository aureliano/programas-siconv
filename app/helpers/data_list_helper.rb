# encoding: utf-8

ProgramasSiconv.helpers do

  def search_data_list()
    page = params[:page].to_i
    tags = get_tags_without_stopwords params[:search_params]
    data_page = DataPage.create(:page_size => 10, :page => page, :total => Programa.count_with_tags({ :tags => tags })) {|index, page_size| Programa.with_tags({ :tags => tags, :page => index, :limit => page_size }) }
    result = data_page.data
    return "<i>Nenhum resultado encontrado.</i>" if result.empty?
    
    d = "#{data_page.total} item(s) encontrado(s).\n<hr/>"
        
    result.each do |programa|      
      d << "<div name=\"div_item_resultado_consulta\">"
      d << "\n  <a href=\"/programa/#{programa.cod_programa_siconv}\"> #{programa.nome}</a><br/>"
      d << "\n  Data de disponibilização: #{time_to_date_s programa.data_disponibilizacao}<br/>"
      d << "\n  Órgãos Relacionados: #{related_concedentes(programa).join '; '}"
      d << "\n</div>"
      d << "\n<br/><br/>\n"
    end
    
    d << pagination_layer(data_page)
  end
  
  private
    def related_concedentes(programa)
      concedentes = []
      concedentes << programa.orgao_superior if programa.orgao_superior
      concedentes << programa.orgao_executor if programa.orgao_executor
      concedentes << programa.orgao_mandatario if programa.orgao_mandatario
      concedentes << programa.orgao_vinculado if programa.orgao_vinculado
      
      concedentes.uniq
    end
end
