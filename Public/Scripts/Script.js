function changeServer(obj){if(obj.options[obj.selectedIndex].value!=''){window.location='index.php?server='+obj.options[obj.selectedIndex].value;}else{window.location='index.php';}}
function serverOnFocus(obj){if(obj.value=='hostname:port'){obj.value='';}}
function serverOnBlur(obj){if(obj.value==''){obj.value='hostname:port';}}
var server=0;function addServer(){var serverDiv=document.createElement('div');var serverID=server++;serverDiv.innerHTML='<div class="row"><div class="left">Server</div>'
+'<div><input type="text" name="server[]" value="hostname:port" onfocus="serverOnFocus(this)" onblur="serverOnBlur(this)">'
+' <a class="menu grey serverlist" style="padding:1px 2px;-moz-border-radius:3px;-webkit-border-radius:3px;" href="#" onclick="deleteServer(\'server_'
+serverID+'\')">Delete</a></div>';serverDiv.setAttribute('id','server_'+serverID);document.getElementById('server_form').appendChild(serverDiv);}
function deleteServer(divID){document.getElementById('server_form').removeChild(document.getElementById(divID));}
var page='stats.php?request_command=live_stats'
function ajax(url,target){if(window.XMLHttpRequest){req=new XMLHttpRequest();req.onreadystatechange=function(){ajaxDone(target);};req.open("GET",url,true);req.send(null);}else if(window.ActiveXObject){req=new ActiveXObject("Microsoft.XMLHTTP");if(req){req.onreadystatechange=function(){ajaxDone(target);};req.open("GET",url,true);req.send();}}
setTimeout("ajax(page,'stats')",timeout);}
function ajaxDone(target){if(req.readyState==4){if(req.status==200||req.status==304){results=req.responseText;document.getElementById(target).innerHTML=results;}else{document.getElementById(target).innerHTML="Loading stats error : "
+req.statusText;}}}