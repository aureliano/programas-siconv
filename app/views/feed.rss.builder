xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "Novos Programas"
    xml.description "Sistema de consulta de Programas de Convênio disponibilizados pelo Governo Federal. Relação de Programas disponibilizados nos últimos #{@last_days} dias."
    xml.link "http://novosprogramas.herokuapp.com/#{url(:feed)}"

    for programa in @programas
      xml.item do
        xml.title programa.nome
        xml.description "Programa de Convênio disponibilizado em #{time_to_date_s programa.data_disponibilizacao} pelo Órgão Administrativo #{programa.orgao_executor}."
        xml.pubDate time_to_date_s programa.data_disponibilizacao
        xml.link "http://novosprogramas.herokuapp.com/programa/#{programa.cod_programa_siconv}"
      end
    end
  end
end
