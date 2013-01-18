# encoding: utf-8

ProgramasSiconv.helpers do

  def search_data_list(options)
    options[:page] ||= pagination_page_index
    data_page = DataPage.new(options)
    return "<i>Nenhum resultado encontrado.</i>" if data_page.data.empty?
    
    d = "#{data_page.total} item(s) encontrado(s).\n<hr/>"
        
    data_page.data.each do |programa|      
      d << "<div name=\"div_item_resultado_consulta\">"
      d << "\n  <a href=\"/programa/#{programa.id}?page=#{params[:page]}&search_params=#{format_get_params params[:search_params]}\"> #{programa.nome}</a><br/>"
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
