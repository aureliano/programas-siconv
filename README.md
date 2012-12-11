programas-siconv
================

Sítio da web: http://novosprogramas.herokuapp.com/

Missão
------

Este sítio tem por objetivo viabilizar a consulta de programas de convênio disponibilizados no portal de convênios do governo federal.
Oferecer uma interface de consulta que possibilite encontrar os programas de convênio que foram disponibilizados recentemente e um mecanismo de Feed.
Os dados apresentados aqui foram retirados do [Portal de Convênios - Siconv] (http://www.convenios.gov.br). Toda informação contida no Siconv é de caráter público e por isso pode e deve ser analisada pelos cidadãos.

Instalação
----------

Pré-requisitos:
- [Ruby] (http://www.ruby-lang.org)
- [Bundler] (http://gembundler.com)
- [wget] (http://www.gnu.org/software/wget/)
- [MongoDB] (http://www.mongodb.org/)

Baixar gems necessárias:
```
bundle install
```

Preparar ambiente de trabalho:
```
padrino rake seed
```

Iniciar aplicação:
```
padrino start
```
Por favor, visite o site do [Padrino] (http://www.padrinorb.com) para obter mais instruções.
