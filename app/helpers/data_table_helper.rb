# encoding: utf-8

ProgramasSiconv.helpers do

  def programas_data_table(options)
    options[:page] ||= pagination_page_index
    data_page = DataPage.new(options)
    return "<i>Nenhum programa encontrado.</i>" if data_page.data.empty?
        
    t = "<table name=\"programas\" class=\"table table-striped\">"
    t << "<thead>"
    t << "\n  <tr>\n    <th>Código</th>\n    <th>Nome</th>\n    <th>Disponibilizado</th>\n  </tr>"
    t << "</thead>"
    
    t << "\n<tboby>"
    data_page.data.each do |programa|
      t << "\n  <tr>\n    <td>#{programa.id}</td>"
      t << "\n    <td>#{programa.nome}</td>"
      t << "\n    <td width=\"150\">#{time_to_date_s programa.data_disponibilizacao}</td>"
      t << "\n    <td><a href=\"programa/#{programa.id}\" class=\"btn btn-primary btn-small\">Detalhar</a></td>"
      t << "\n  </tr>"
    end
    
    t << "\n</tbody>"
    t << "\n</table>"
    t << pagination_layer(data_page)
    
    t << "\n<hr/><div name=\"div_total_programas\">Total de programas: #{data_page.total}</div>"
  end
  
  def pagination_layer(data_page)
    t = "<div class=\"pagination\">"
    t << "\n <ul>"
    
    t << "\n <li#{data_page.has_previous_pagination_block? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_previous_pagination_block? ? pagination_url(data_page.previous_block_page) : 'javascript: void(0)'}\">&lt;&lt;</a></li>"
    t << "\n <li#{data_page.has_previous_page? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_previous_page? ? pagination_url(data_page.previous_page) : 'javascript: void(0)'}\">&lt;</a></li>"
    
    data_page.current_page_block.each do |page|
      t << "\n <li#{(data_page.page_index == page) ? ' class="disabled"' : ''}><a href=\"#{(data_page.page_index == page) ? 'javascript: void(0)' : pagination_url(page)}\">#{page}</a></li>"
    end
    
    t << "\n <li#{data_page.has_next_page? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_next_page? ? pagination_url(data_page.next_page) : 'javascript: void(0)'}\">&gt;</a></li>"
    t << "\n <li#{data_page.has_next_pagination_block? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_next_pagination_block? ? pagination_url(data_page.next_block_page) : 'javascript: void(0)'}\">&gt;&gt;</a></li>"
    
    t << "\n </ul>"
    t << "</div>"
    
    data_page.pages > 1 ? t : ''
  end
  
  def pagination_url(page_index)
    params[:search_params] ? "?search_params=#{params[:search_params].gsub(/\s/, '+')}&page=#{page_index}" : "?page=#{page_index}"
  end

end
