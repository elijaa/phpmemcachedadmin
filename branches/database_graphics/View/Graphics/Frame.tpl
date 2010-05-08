<br />
<script type="text/javascript">
//initiate a recurring data update
$(function () {
     var options =
         {
        lines: { show: true, lineWidth: 2, fill: true},
        xaxis: { mode: "time" },
        yaxis: { min: 0,
        	tickFormatter: function suffixFormatter(val, axis) {
                if (val > 1000000)
                    return (val / 1000000).toFixed(axis.tickDecimals) + "M";
                  else if (val > 1000)
                    return (val / 1000).toFixed(axis.tickDecimals) + "k";
                  else
                    return val.toFixed(axis.tickDecimals);
                } },
        legend: {
            show: true,
            container: $("#legend")
          },
        crosshair: {
              mode: "x"
          },
        series: {
            //stack: true,
            shadowSize: 0,
            lineHeight: 1
          },
        grid: {
               // backgroundColor: "#B5463F",
               // color: "#444444",
                borderWidth: 1,
                hoverable: true,
                autoHighlight: true
            }
    };
    var data = [];
    var request = '<?php echo (isset($_GET['stats'])) ? $_GET['stats']:''; ?>';
    var server = '<?php echo (isset($_GET['server'])) ? $_GET['server']:''; ?>';
    var placeholder = $("#placeholder");

    $.plot(placeholder, data, options);

 function fetchData() {
     $.ajax({
         // usually, we'll just call the same URL, a script
         // connected to a database, but in this case we only
         // have static example files so we need to modify the
         // URL
         url: "graphics.php?request_method=ajax&stats=" + request + "&server=" + server,
         method: 'GET',
         dataType: 'json',
         success: onDataReceived
     });
     setTimeout(fetchData, <?php echo $_ini->get('refresh_rate') * 1000; ?>);
 }

 function onDataReceived(series) {
     //No reset : Append
     data = [];
     $.each(series, function(key, val)
     {
         data.push(series[key]);
     });

     $.plot($("#placeholder"), data, options);
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
<div class="container rounded" style="padding-left: 4px;"><br/>
Switch to :
        <select class="" onchange="changeGraphic(this, '<?php echo (isset($_GET['stats'])) ? $_GET['stats']:''; ?>')">
        <option value="" <?php if(!isset($_GET['server']) || ($_GET['server'] == '')) { echo 'selected="selected"'; } ?>>All Servers</option>
<?php
# Servers
foreach($_ini->get('server') as $server)
{ ?>
        <option value="<?php echo $server; ?>" <?php if((isset($_GET['server'])) && ($_GET['server'] == $server)) { echo 'selected="selected"'; } ?>>
            <?php echo $server; ?>
        </option>
<?php
} ?>
        </select>
<div id="placeholder" style="width: 810px; height: 400px; position: relative; background: #FFFFFF;"></div>
</div>
<br />

<div class="container rounded" id="legend"></div>
</div>
