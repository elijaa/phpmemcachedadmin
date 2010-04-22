<br/>
<script type="text/javascript">
//initiate a recurring data update
$(function () {
 // reset data
     var options = {
        lines: { show: true },
        xaxis: { mode: "time" },
        legend: {
            show: true,
            position: "nw",
            backgroundOpacity: 0,
            container: $("#legend")
          },
        series: {
            lines: { show: true},
            shadowSize: 0
          },

        //points: { show: true },
        //xaxis: { tickDecimals: 0, tickSize: 1 }
    };
    var data = [];
    var placeholder = $("#placeholder");

 $.plot(placeholder, data, options);

 function fetchData() {

     function onDataReceived(series) {
         // we get all the data in one go, if we only got partial
         // data, we could merge it with what we already got

         $.each(series, function(key, val)
         {
             data.push(series[key]);
        	 //data = [val];
        	 $.plot($("#placeholder"), data, options);
         });

         data = [];
     }

     $.ajax({
         // usually, we'll just call the same URL, a script
         // connected to a database, but in this case we only
         // have static example files so we need to modify the
         // URL
         url: "stats.php?request_command=ajax",
         method: 'GET',
         dataType: 'json',
         success: onDataReceived
     });
     setTimeout(fetchData, <?php echo $_ini->get('refresh_rate') * 1000; ?>);
 }

 setTimeout(fetchData, <?php echo $_ini->get('refresh_rate') * 1000; ?>);
});

</script>

<div style="float: left;">
    <div class="title grey rounded">Live <span class="green">Stats</span></div>
    <div style="padding-left:4px;">
        <br/>
        <div id="placeholder" style="width: 824px; height: 400px; position: relative;">
        Loading live stats, please wait ...</div>
    </div>
    <div id="legend"></div>
</div>
