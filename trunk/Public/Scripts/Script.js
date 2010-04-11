/**
 * Used onchange of the header select
 * 
 * @param server
 * @return void
 */
function changeServer(obj) {
	if (obj.options[obj.selectedIndex].value != '') {
		window.location = 'index.php?server=' + obj.options[obj.selectedIndex].value;
	} else {
		window.location = 'index.php';
	}
}

/**
 * Used onfocus of the server input
 * 
 * @param input
 * @return void
 */
function serverOnFocus(obj) {
	if (obj.value == 'hostname:port') {
		obj.value = '';
	}
}

/**
 * Used onblur of the server input
 * 
 * @param input
 * @return void
 */
function serverOnBlur(obj) {
	if (obj.value == '') {
		obj.value = 'hostname:port';
	}
}

var server = 0;
/**
 * Add a server to configuration
 * 
 * @return void
 */
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

/**
 * Delete a server from configuration
 * 
 * @param integer
 * @return void
 */
function deleteServer(divID) {
	document.getElementById('server_form').removeChild(
			document.getElementById(divID));
}