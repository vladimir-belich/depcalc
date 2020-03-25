function get_calc(form){
  params = [];
  params.push('sum=' + document.getElementById('sum').value);
  params.push('interest_rate=' + document.getElementById('interest_rate').value);
  params.push('start_date=' + document.getElementById('start_date').value);
  let coeff = document.getElementById('term_length').value == 'months' ? 1 : 12;
  params.push('months=' + document.getElementById('term').value * coeff);
  params.push('capitalization_method=' + document.getElementById('capitalization').selectedIndex);
  params = params.join('&');

  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/table?' + params, true);
  xhr.send(params);

  xhr.onreadystatechange = function() {
    if(xhr.readyState == 4 && xhr.status == 200) {
      table_container = document.getElementById('table_container');
      table_container.style.display = 'block';

      element = document.getElementById('table');
      element.innerHTML = xhr.responseText;
    }
  }
}

function get_file(form){
  params = [];
  params.push('sum=' + document.getElementById('sum').value);
  params.push('interest_rate=' + document.getElementById('interest_rate').value);
  params.push('start_date=' + document.getElementById('start_date').value);
  let coeff = document.getElementById('term_length').value == 'months' ? 1 : 12;
  params.push('months=' + document.getElementById('term').value * coeff);
  params.push('capitalization_method=' + document.getElementById('capitalization').selectedIndex);
  params = params.join('&');

  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/file?' + params, true);
  xhr.send(params);

  xhr.onreadystatechange = function() {
    if(xhr.readyState == 4 && xhr.status == 200) {
      download('output.csv', xhr.responseText)
    }
  }
}

function download(filename, text) {
    var element = document.createElement('a');
    element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
    element.setAttribute('download', filename);

    element.style.display = 'none';
    document.body.appendChild(element);

    element.click();

    document.body.removeChild(element);
}
