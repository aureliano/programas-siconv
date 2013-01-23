# encoding: utf-8

Então /^eu devo ver a página de informações do projeto$/ do
  should have_text "Este sítio tem por objetivo viabilizar a consulta de programas de convênio disponibilizados no portal de convênios do governo federal"

  should have_text "Desde 2008 está no ar o Portal de Convênios - Siconv. Sistema responsável pela tramitação de todo o processo de transferência voluntária."
  should have_text "Convênios são acordos, ajustes ou qualquer outro instrumento que discipline a transferência de recursos financeiros de dotações consignadas nos Orçamentos Fiscal e da Seguridade Social da União e tenha como participe, de um lado, órgão ou entidade da administração pública federal, direta ou indireta , ou ainda, entidades privadas sem fins lucrativos, visando a execução de programa de governo, envolvendo a realização de projeto, atividade, seviço, aquisição de bens ou evento de interesse recíproco, em regime de mútua cooperação."
  should have_text "Decreto nº 6.170, de 25 de julho de 2007"
end
