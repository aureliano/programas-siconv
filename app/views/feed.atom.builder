xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title   "Novos Programas"
  xml.link    "rel" => "self", "href" => 'http://novosprogramas.herokuapp.com'
  xml.id      url(:feed)
  xml.updated @programas.last.data_disponibilizacao.strftime "%Y-%m-%dT%H:%M:%SZ" if @programas.any?
  xml.author  { xml.name "Novos Programas" }

  @programas.each do |programa|
    xml.entry do
      xml.title   programa.nome
      xml.link    "rel" => "alternate", "href" => "http://novosprogramas.herokuapp.com/programa/#{programa.cod_programa_siconv}"
      xml.id      "http://novosprogramas.herokuapp.com/programa/#{programa.cod_programa_siconv}"
      xml.updated programa.data_disponibilizacao.strftime "%Y-%m-%dT%H:%M:%SZ"
      xml.author  { xml.name programa.orgao_executor }
    end
  end
end
