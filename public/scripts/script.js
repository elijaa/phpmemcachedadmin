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
 * Used onfocus of the search input
 * 
 * @param obj
 * @return void
 */
function searchOnFocus(obj) {
	if (obj.value == 'Enter a key to search') {
		obj.value = '';
	}
}

/**
 * Used onblur of the search input
 * 
 * @param obj
 * @return void
 */
function searchOnBlur(obj) {
	if (obj.value == '') {
		obj.value = 'Enter a key to search';
	}
}