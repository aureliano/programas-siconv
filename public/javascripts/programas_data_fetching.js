$(document).ready(function() {
  var url = window.location.pathname;
  var programa_id = url.substring(url.lastIndexOf('/') + 1, url.length);  
  var jsonUrl = 'http://api.convenios.gov.br/siconv/dados/programa/' + programa_id + '.json';
  
  $.getJSON(jsonUrl, function(data) {
    var hash = data['programas'][0];
    
    $('span#tx_descricao').text(hash['descricao']);
    $('span#tx_acao_orcamentaria').text(hash['acao_orcamentaria']);
  }).error(function() { alert('Nem todas informações do programa foram carregadas. Tente acessar esta página novamente mais tarde.') });
});
