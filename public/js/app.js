function post_params(form){
  var xhr = new XMLHttpRequest()
  xhr.open('POST', '/tabl', true)

  xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

  params = [];
  params.push('sum=' + document.getElementById('sum').value);
  params.push('interest_rate=' + document.getElementById('interest_rate').value);
  params.push('start_date=' + document.getElementById('start_date').value);
  let coeff = document.getElementById('term_length').value == 'months' ? 1 : 12;
  params.push('months=' + document.getElementById('term').value * coeff);
  params.push('capitalization_method=' + document.getElementById('capitalization').selectedIndex);

  xhr.send(params.join('&'));

  xhr.onreadystatechange = function() {

    if(xhr.readyState == 4 && xhr.status == 200) {
      element = document.getElementById('tab_container');
      element.style.display = 'block';
      element.innerHTML = xhr.responseText;
    }
  }
}