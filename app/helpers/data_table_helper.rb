# encoding: utf-8

ProgramasSiconv.helpers do

  def programas_data_table(data_method, count_method, filter)
    page = params[:page].to_i
    data_page = DataPage.create(:page_size => 10, :page => page, :total => Programa.send(count_method, filter)) {|index, page_size| filter[:page] = index; filter[:limit] = page_size; Programa.send(data_method, filter) }
    programas = data_page.data
    return "<i>Nenhum programa encontrado.</i>" if programas.empty?
    
    t = "<table name=\"programas\" class=\"table table-striped\">"
    t << "<thead>"
    t << "\n  <tr>\n    <th>Código</th>\n    <th>Nome</th>\n    <th>Disponibilizado</th>\n  </tr>"
    t << "</thead>"
    
    t << "\n<tboby>"
    programas.each do |programa|
      t << "\n  <tr>\n    <td>#{programa.cod_programa_siconv}</td>"
      t << "\n    <td>#{programa.nome}</td>"
      t << "\n    <td width=\"150\">#{time_to_date_s programa.data_disponibilizacao}</td>"
      t << "\n    <td><a href=\"programa/#{programa.cod_programa_siconv}\" class=\"btn btn-primary btn-small\">Detalhar</a></td>"
      t << "\n  </tr>"
    end
    
    t << "\n</tbody>"
    t << "\n</table>"
    t << pagination_layer(data_page)
    
    t << "\n<hr/><div>Total de programas: #{data_page.total}</div>"
  end
  
  def pagination_layer(data_page)
    t = "<div class=\"pagination\">"
    t << "\n  <ul>"
    
    find_page_function = "onclick=\"javascript: sendPageIndex(#{data_page.previous_block_page})\""
    t << "\n    <li #{data_page.has_previous_pagination_block? ? '' : 'class="disabled"'}><a href=\"#{data_page.has_previous_pagination_block? ? '#' : 'javascript: void(0)'}\" #{data_page.has_previous_pagination_block? ? find_page_function : ''}>&lt;&lt;</a></li>"
    
    find_page_function = "onclick=\"javascript: sendPageIndex(#{data_page.previous_page})\""
    t << "\n    <li #{data_page.has_previous_page? ? '' : 'class="disabled"'}><a href=\"#{data_page.has_previous_page? ? '#' : 'javascript: void(0)'}\" #{data_page.has_previous_page? ? find_page_function : ''}>&lt;</a></li>"
    
    data_page.current_page_block.each do |page|
      find_page_function = "onclick=\"javascript: sendPageIndex(#{page})\""
      t << "\n    <li #{(data_page.page_index ==  page) ? 'class="disabled"' : ''}><a href=\"#{(data_page.page_index ==  page) ? 'javascript: void(0)' : '#'}\" #{(data_page.page_index ==  page) ? '' : find_page_function}>#{page}</a></li>"
    end
    
    find_page_function = "onclick=\"javascript: sendPageIndex(#{data_page.next_page})\""
    t << "\n    <li #{data_page.has_next_page? ? '' : 'class="disabled"'}><a href=\"#{data_page.has_next_page? ? '#' : 'javascript: void(0)'}\" #{data_page.has_next_page? ? find_page_function : ''}>&gt;</a></li>"
    
    find_page_function = "onclick=\"javascript: sendPageIndex(#{data_page.next_block_page})\""
    t << "\n    <li #{data_page.has_next_pagination_block? ? '' : 'class="disabled"'}><a href=\"#{data_page.has_next_pagination_block? ? '#' : 'javascript: void(0)'}\" #{data_page.has_next_pagination_block? ? find_page_function : ''}>&gt;&gt;</a></li>"
    
    t << "\n  </ul>"
    t << "</div>\n<input id=\"page\" name=\"page\" type=\"hidden\" value=\"#{data_page.page_index}\"/>"
  end

end
