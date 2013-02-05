function validateDays() {
  var intRegex = /^\d+$/;
  var lastDays = document.getElementById('last_days').value;
  var isInt = intRegex.test(lastDays);
  
  if (!isInt)
    alert('Você deve informar um número inteiro como filtro!\nEncontrado: ' + lastDays);
    
  return isInt;
}
