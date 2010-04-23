<br/>
<script type="text/javascript">
//initiate a recurring data update
$(function () {
 $("#dialog").dialog({
            height: 180,
            width: 407,
            modal: true,
            autoOpen: false,
            buttons: {
                "Cancel": function() { $(this).dialog("close"); },
                "Change": function() {
                	request = $("#stats option:selected").val()
                    $.ajax({
                        url: "graphics.php?request_method=ajax&request_stats=" + request,
                        method: 'GET',
                        dataType: 'json',
                        success: onDataReceived
                    });
                    $(this).dialog("close");
                }
            }
        });

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

<div id="dialog">
        <span class="title grey" style="width:393px;">Get <span class="green">Command</span></span>
        <div class="container" style="width:393px;padding:7px">
               <div class="row">
                    Execute get command on one or all memcached servers<br/>
                    <hr/>
                </div>
                <div class="row">
                    <div class="left">Server</div>
                    <div><?php echo Library_HTML::serverList(); ?></div>
                </div>
                <div class="row">
                    <div class="left">Stats</div>
                    <div>
                    <select id="stats">
                        <option value="" style="background:#514845;">Commands</option>
                        <option value="cmd_total">- All</option>
                        <option value="cmd_get">- Get</option>
                        <option value="cmd_set">- Set</option>
                        <option value="cmd_delete">- Delete</option>
                        <option value="cmd_cas">- Cas</option>
                        <option value="cmd_incr">- Increment</option>
                        <option value="cmd_decr">- Decrement</option>
                        <option value="" style="background:#514845;">Rate</option>
                        <option value="request_rate">- Global Hit & Miss Rate</option>
                        <option value="get_rate">- Get Rate</option>
                        <option value="set_rate">- Set Rate</option>
                        <option value="delete_rate">- Delete Rate</option>
                        <option value="cas_rate">- Cas Rate</option>
                        <option value="incr_rate">- Increment Rate</option>
                        <option value="decr_rate">- Decrement Rate</option>
                    </select>
                    </div>
                </div>
        </div>
</div>


<div style="float: left;">
    <div class="title grey rounded">Live <span class="green">Stats</span></div>
    <div style="padding-left:4px;">
        <br/>
        <a href="#" onclick="jQuery('#dialog').dialog('open'); return false">Change chart options ...</a>
        <div id="placeholder" style="width:820px;height:400px;position:relative;"></div>
    </div>
    <div id="legend"></div>
</div>
