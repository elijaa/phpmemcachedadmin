<br/>
<script type="text/javascript">
var initTimeout = 5000;
var timeout = <?php echo $_ini->get('refresh_rate') * 1000; ?>;
setTimeout("ajax(page,'stats')", 5000);
</script>

<div style="float: left;">
    <span class="title grey rounded" style="width:772px;">Live <span class="green">Stats</span></span>
    <div style="width:772px;padding-left:4px;">
        <br/>
        <pre id="stats" style="font-size:12px;overflow:visible;">
        Loading live stats, please wait 5 seconds ...</pre>
    </div>
</div>
