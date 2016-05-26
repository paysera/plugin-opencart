<style type="text/css">

.w2p-table {
	width: 100%;
    margin-top: 10px;
    margin-left: 25px;
}

.w2p-table img {
	cursor: pointer;
}

.w2p-table td.radio {
	width: 30px;
}

</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#w2p-cs').change(function() {
			var value = $('#w2p-cs option:selected').val();
			$('input[name="pmethod"]').each(function(){
				$(this).attr('checked', false);
			});
			$('.w2p-table').each(function(){
		        var tid = $(this).attr('rel');
		        if(tid == value) {
		        	$(this).css({'display' : 'block'});
		        } else {
		        	$(this).css({'display' : 'none'});
		        }
		    });
		});
		$('tr').click(function(){
			$(this).children('td').children('input').attr('checked', true);
		});
	});
</script>

<div class="content">
	<form action="<?php echo $action; ?>" method="post" id="wtp-checkout">
        <table>
            <tr>
                <td colspan=2">
                    <h2><?php echo $text_chosen; ?></h2></td>
            </tr>

            <?php if($paysera_display_payments == 1){ ?>
            <tr>
                <td><?php
                 if($payment_country){
                    $country_iso = strtolower($payment_country);

                    $countries = $evp_countries;
                    if(!isset($countries[$country_iso])){
                   $country_iso = $default_country; }
}
                    ?></td>
                <td>
                    <select id="w2p-cs">
                        <?php

                    foreach($countries as $country ){ ?>
                        <?php echo var_dump($country) ?>
                        <?php if($country->getCode() == $country_iso){ ?>
                        <option value="<?php echo $country->getCode(); ?>" selected="selected"><?php echo $country->getTitle(); ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $country->getCode(); ?>"><?php echo $country->getTitle(); ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </td>
            </tr>
            <?php } ?>






        </table>
        <?php if($paysera_display_payments == 1): ?>
        <div style="float: left; width: 100%;" >
            <?php foreach ($countries as $country): ?>
            <table rel="<?php echo $country->getCode(); ?>" class="w2p-table" style="display: <?php echo ($country->getCode() == $country_iso) ? 'block' : 'none' ?>;">
                <?php foreach ($country->getGroups() as $group): ?>
                <tr>
                    <td colspan="2"><b><?php echo $group->getTitle(); ?></b></td>
                </tr>
                <?php foreach ($group->getPaymentMethods() as $paymentMethod): ?>
                <?php if ($paymentMethod->getLogoUrl()): ?>
                <tr>
                    <td class="radio">
                        <input type="radio" class="radio" name="payment" value="<?php echo $paymentMethod->getKey(); ?>" />
                    </td>
                    <td>
                        <img src="<?php echo $paymentMethod->getLogoUrl(); ?>"
                             title="<?php echo $paymentMethod->getTitle(); ?>"
                             alt="<?php echo $paymentMethod->getTitle(); ?>"
                                />
                    </td>
                </tr>
                <?php endif; ?>
                <?php endforeach; ?>
                <?php endforeach; ?>
            </table>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
    	<div style="clear:both;"></div>
	</form>
</div>
<div class="buttons">
    <div class="pull-right">
                <button id="button-confirm" class="btn btn-primary" style="text-indent: 0px;"><?php echo $button_confirm; ?></button>

    </div>


<script type="text/javascript"><!--
$('.confirm-button').on('click', function() {
	$('#wtp-checkout').submit();
});
$('#button-confirm').on('click', function() {
	$('#wtp-checkout').submit();
});
//--></script>



</div>
