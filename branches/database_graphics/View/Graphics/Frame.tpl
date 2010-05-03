<br />
<script type="text/javascript">
//initiate a recurring data update
$(function () {
     var options =
         {
        lines: {
         show: true,
          lineWidth: 1,
           fill: true,
            fillColor: false
             },
        xaxis: { mode: "time" },
        yaxis: { min: 0,
        	tickFormatter: function suffixFormatter(val, axis) {
                if (val > 1000000)
                    return (val / 1000000).toFixed(axis.tickDecimals) + "MB";
                  else if (val > 1000)
                    return (val / 1000).toFixed(axis.tickDecimals) + "kB";
                  else
                    return val.toFixed(axis.tickDecimals) + "B";
                } },
        legend: {
            show: true,
            container: $("#legend")
          },
        crosshair: {
              mode: "x"
          },
        series: {
            lines: { show: true},
            shadowSize: 0,
            lineHeight: 1
          },
        grid: {
                backgroundColor: "#B5463F",
                borderWidth: 1,
                hoverable: true,
                autoHighlight: true
            }
    };
    var data = [];
    var request = '<?php echo (isset($_GET['stats'])) ? $_GET['stats']:''; ?>';
    var placeholder = $("#placeholder");
    var choiceContainer = $("#choices");
    var i = 0;
    var checkboxMade = false;

    $.plot(placeholder, data, options);

 function fetchData() {
     $.ajax({
         // usually, we'll just call the same URL, a script
         // connected to a database, but in this case we only
         // have static example files so we need to modify the
         // URL
         url: "graphics.php?request_method=ajax&stats=" + request,
         method: 'GET',
         dataType: 'json',
         success: onDataReceived
     });
     setTimeout(fetchData, <?php echo $_ini->get('refresh_rate') * 1000; ?>);
 }

 function onDataReceived(series) {
     // we get all the data in one go, if we only got partial
     // data, we could merge it with what we already got

     $.each(series, function(key, val)
     {
         /*
    	 choiceContainer.find("input:checked").each(function () {
             var keyName = $(this).attr("name");
             if(key == keyName)
             {
                 alert('toto');
                 */
                 data.push(series[key]);
      /*       }
    	 });

         /* Checkbox */
         if(checkboxMade == false)
         {
             /* Color switching */
             val.color = i;
             ++i;

             $.plot(placeholder, data, options);
             choiceContainer.append('<br/><input type="checkbox" name="' + key +
                     '" checked="checked" id="' + key + '">' +
                     '<label for="' + key + '">'
                      + val.label + '</label>');
             checkboxMade = true;
         }


     });
/*
     choiceContainer.find("input:checked").each(function () {
         var key = $(this).attr("name");
         if(series[key])
         {
             data.push(series[key]);
         }
     });*/
     //data = [];
 }

 /* Bind hover */
 $("#placeholder").bind("plothover",  function (event, pos, item) {

     if (item) {
         //item.datapoint;

       }
 });

 setTimeout(fetchData, 0);
});

</script>

<div style="float: left;">
<div class="title grey rounded size1">Graphics <span class="green">Stats</span></div>
<div class="container rounded" style="padding-left: 4px;"><br />
<div id="placeholder"
	style="width: 810px; height: 400px; position: relative; background: #FFFFFF;"></div>
</div>
<br />
<p id="choices">Show:</p>
<div class="container rounded" id="legend"></div>
</div>
