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

// Page to load for live_stats
var page = 'stats.php?request_command=live_stats'

/**
 * Ajax loading for live_stats
 * 
 * @param string
 * @param string
 * @return
 */
function ajax(url, target) {
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
		req.onreadystatechange = function() {
			ajaxDone(target);
		};
		req.open("GET", url, true);
		req.send(null);

		// IE/Windows ActiveX version
	} else if (window.ActiveXObject) {
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req) {
			req.onreadystatechange = function() {
				ajaxDone(target);
			};
			req.open("GET", url, true);
			req.send();
		}
	}
	setTimeout("ajax(page,'stats')", timeout);
}

/**
 * Ajax loading done, displaying on screen
 * 
 * @param string
 * @return
 */
function ajaxDone(target) {
	// Request loaded
	if (req.readyState == 4) {
		// Status OK
		if (req.status == 200 || req.status == 304) {
			results = req.responseText;
			document.getElementById(target).innerHTML = results;
		} else {
			document.getElementById(target).innerHTML = "Loading stats error : "
					+ req.statusText;
		}
	}
}