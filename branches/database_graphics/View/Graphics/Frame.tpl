<br/>
<script type="text/javascript">
//initiate a recurring data update
$(function () {
     var options = {
        lines: { show: true },
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
        series: {
            lines: { show: true},
            shadowSize: 0,
            lineHeight: 1
          }
    };
    var data = [];
    var request = '';
    var placeholder = $("#placeholder");

 $.plot(placeholder, data, options);

 function fetchData() {
     $.ajax({
         // usually, we'll just call the same URL, a script
         // connected to a database, but in this case we only
         // have static example files so we need to modify the
         // URL
         url: "graphics.php?request_method=ajax&request_stats=" + request,
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
         data.push(series[key]);
         //data = [val];
         $.plot($("#placeholder"), data, options);
     });

     data = [];
 }

 setTimeout(fetchData, 0);
});

</script>

<div style="float: left;">
    <div class="title grey rounded">Live <span class="green">Stats</span></div>
    <div style="padding-left:4px;">
        <br/>
        <div id="placeholder" style="width:820px;height:400px;position:relative;"></div>
    </div>
    <div id="legend"></div>
</div>
