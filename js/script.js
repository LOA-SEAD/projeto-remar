var tr = document.createElement('tr');
tr.setAttribute('id', '2');
tr.setAttribute('data-version', '0');
tr.setAttribute('class', 'odd');

var td1 = document.createElement('td');
td1.setAttribute('tabindex', '1');
td1.innerText = 'teste';

var td2 = document.createElement('td');
td2.setAttribute('tabindex', '1');
td2.innerText = 'teste';

var td3 = document.createElement('td');
td3.setAttribute('tabindex', '1');
td3.innerText = 'teste';

tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);

var table = document.getElementById('table');

var tbody = table.getElementsByTagName('tbody')[0];

tbody.appendChild(tr);

$('#table').editableTableWidget();
