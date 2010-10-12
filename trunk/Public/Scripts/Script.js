function changeServer(obj) {
	if (obj.options[obj.selectedIndex].value != '') {
		window.location = 'index.php?server=' + obj.options[obj.selectedIndex].value;
	} else {
		window.location = 'index.php';
	}
}

function changeCluster(obj) {
	if (obj.options[obj.selectedIndex].value != '') {
		window.location = 'stats.php?cluster=' + obj.options[obj.selectedIndex].value;
	} else {
		window.location = 'stats.php';
	}
}

function changeCommand(obj) {
	document.getElementById('request_key').value = '';
	document.getElementById('request_duration').value = '';
	document.getElementById('request_data').value = '';
	document.getElementById('request_delay').value = '';

	var command = obj.options[obj.selectedIndex].value;
	var div_key = document.getElementById('div_key');
	var div_duration = document.getElementById('div_duration');
	var div_data = document.getElementById('div_data');
	var div_delay = document.getElementById('div_delay');

	if (command == 'get' || command == 'delete') {
		div_key.style.display = '';
		div_duration.style.display = 'none';
		div_data.style.display = 'none';
		div_delay.style.display = 'none';
	} else if (command == 'set') {
		div_key.style.display = '';
		div_duration.style.display = '';
		div_data.style.display = '';
		div_delay.style.display = 'none';
	} else if (command == 'flush_all') {
		div_key.style.display = 'none';
		div_duration.style.display = 'none';
		div_data.style.display = 'none';
		div_delay.style.display = '';
	} else {
		div_key.style.display = 'none';
		div_duration.style.display = 'none';
		div_data.style.display = 'none';
		div_delay.style.display = 'none';
	}
}

function executeClear(target)
{
    var object = document.getElementById(target);
    object.innerHTML = '';
}

function executeCommand(target) {
	if(document.getElementById('request_command').value != '')
	{
		var request_url = 'commands.php?request_command=' + document.getElementById('request_command').value + 
		'&request_key=' + document.getElementById('request_key').value + 
		'&request_duration=' + document.getElementById('request_duration').value + 
		'&request_data=' + document.getElementById('request_data').value + 
		'&request_delay=' + document.getElementById('request_delay').value + 
		'&request_server=' + document.getElementById('request_server').value + 
		'&request_api=' + document.getElementById('request_api').value;
		
		execute(request_url, target, true);
	}
}

function executeScript() {

}

function searchKey(target) {
	if(document.getElementById('search_key').value != '')
	{
		var request_url = 'commands.php?request_command=search' +
		'&request_key=' + document.getElementById('search_key').value +
		'&request_server=' + document.getElementById('search_server').value;
		
		execute(request_url, target, true);
	}
}

function execute(url, target, append) {
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
		req.onreadystatechange = function() {
			onExecute(target, append);
		};
		req.open('GET', url, true);
		req.send(null);
	} else if (window.ActiveXObject) {
		req = new ActiveXObject('Microsoft.XMLHTTP');
		if (req) {
			req.onreadystatechange = function() {
				onExecute(target, append);
			};
			req.open('GET', url, true);
			req.send();
		}
	}
}

function onExecute(target, append) {
	if (req.readyState == 4) {
		if (req.status == 200 || req.status == 304) {
			if(append == true)
			{
				var object = document.getElementById(target);
				object.innerHTML += req.responseText;
				object.scrollTop = object.scrollHeight;
			}
			else
			{
				var object = document.getElementById(target);
				object.innerHTML = req.responseText;
				object.scrollTop = object.scrollHeight;
			}
		}
	}
}

function serverOnFocus(obj) {
	if (obj.value == 'hostname:port') {
		obj.value = '';
	}
}
function serverOnBlur(obj) {
	if (obj.value == '') {
		obj.value = 'hostname:port';
	}
}
function flushServer(obj) {
	if (confirm('Are you sure you want to execute flush_all on server') == true) {
		obj.submit();
	}
	return false;
}
var server = 0;
function addServer() {
	var serverDiv = document.createElement('div');
	var serverID = server++;
	serverDiv.innerHTML = '<div class="row"><div class="left">Server</div>'
			+ '<div><input type="text" name="server[]" value="hostname:port" onfocus="serverOnFocus(this)" onblur="serverOnBlur(this)">'
			+ ' <a class="menu grey serverlist" style="padding:1px 2px;-moz-border-radius:3px;-webkit-border-radius:3px;" href="#" onclick="deleteServer(\'server_'
			+ serverID + '\')">Delete</a></div>';
	serverDiv.setAttribute('id', 'server_' + serverID);
	document.getElementById('server_form').appendChild(serverDiv);
}
function deleteServer(divID) {
	document.getElementById('server_form').removeChild(
			document.getElementById(divID));
}

function ajax(url, target) {
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
		req.onreadystatechange = function() {
			ajaxDone(target);
		};
		req.open("GET", url, true);
		req.send(null);
	} else if (window.ActiveXObject) {
		req = new ActiveXObject('Microsoft.XMLHTTP');
		if (req) {
			req.onreadystatechange = function() {
				ajaxDone(target);
			};
			req.open("GET", url, true);
			req.send();
		}
	}
	setTimeout("ajax(page, 'stats')", timeout);
}
function ajaxDone(target) {
	if (req.readyState == 4) {
		if (req.status == 200 || req.status == 304) {
			results = req.responseText;
			document.getElementById(target).innerHTML = results;
		} else {
			document.getElementById(target).innerHTML = "Loading stats error : "
					+ req.statusText;
		}
	}
}