function sendPageIndex(index) {
  var pageField = $('form input#page')[0];
  if (pageField == undefined) {
    return;
  }
  
  pageField.value = index;
  pageField.form.submit();
}
