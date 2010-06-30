<br/>
<script type="text/javascript">
var timeout = <?php echo $_ini->get('refresh_rate') * 1000; ?>;
setTimeout("ajax(page,'stats')", 5000);
</script>

<div style="float: left;">
    <div class="sub-header corner full-size padding">Live <span class="green">Stats</span></div>
    <div class="container corner padding">
        <pre id="stats" style="font-size:12px; overflow:visible;" class="full-size">

        Loading live stats, please wait 5 seconds ...
        </pre>
    </div>
</div>
