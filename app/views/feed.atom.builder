xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title   "TVSonar"
  xml.link    "rel" => "self", "href" => url_for(:posts, :index)
  xml.id      url(:feed)
  xml.updated @programas.last.data_disponibilizacao.strftime "%Y-%m-%dT%H:%M:%SZ" if @programas.any?
  xml.author  { xml.name "TVSonar" }

  @programas.each do |programa|
    xml.entry do
      xml.title   programa.nome
      xml.link    "rel" => "alternate", "href" => "/programa/#{programa.cod_programa_siconv}"
      xml.id      "/programa/#{programa.cod_programa_siconv}"
      xml.updated programa.data_disponibilizacao.strftime "%Y-%m-%dT%H:%M:%SZ"
      xml.author  { xml.name programa.orgao_executor }
    end
  end
end
