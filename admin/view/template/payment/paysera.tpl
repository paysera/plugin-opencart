<?php echo $header; ?>

<?php if ($error_warning): ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php endif; ?>

<div class="box">
    <div class="heading">
        <h1 style="background-image: url('view/image/payment.png');"><?php echo $heading_title; ?></h1>
        <div class="buttons">
        	<a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
        	<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
        </div>
    </div>
    <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
            <table class="form">
            	<tr>
            		<td><span class="required">*</span> <?php echo $entry_project; ?></td>
            		<td><input type="text" name="paysera_project" value="<?php echo $paysera_project; ?>" /> <br />
            			<?php if ($error_project): ?>
            			<span class="error"><?php echo $error_project; ?></span>
            			<?php endif; ?>
            		</td>
            	</tr>
            	<tr>
            		<td><span class="required">*</span> <?php echo $entry_sign; ?></td>
            		<td>
            			<input type="text" name="paysera_sign" value="<?php echo $paysera_sign; ?>" /><br />
            			<?php if ($error_sign): ?>
						<span class="error"><?php echo $error_sign; ?></span>
            			<?php endif; ?>
            		</td>
            	</tr>
            	<tr>
            		<td><span class="required">*</span> <?php echo $entry_lang; ?></td>
            		<td>
            			<input type="text" name="paysera_lang" value="<?php echo $paysera_lang; ?>" /> <br />
            			<?php if ($error_lang): ?>
						<span class="error"><?php echo $error_lang; ?></span>
            			<?php endif; ?>
            		</td>
            	</tr>
            	<tr>
            		<td><?php echo $entry_test; ?></td>
            		<td>
                		<select name="paysera_test">
          					<?php if($paysera_test == 0): ?>
                    			<option value="0" selected="selected"><?php echo $text_off; ?></option>
                    			<option value="100"><?php echo $text_on; ?></option>
                			<?php else: ?>
                    			<option value="0"><?php echo $text_off; ?></option>
                    			<option value="100" selected="selected"><?php echo $text_on; ?></option>
                			<?php endif;?>
                		</select>
            		</td>
            	</tr>
            	<tr>
            		<td><?php echo $entry_order_status; ?></td>
            		<td>
            			<select name="paysera_order_status_id">
            		    <?php foreach ($order_statuses as $order_status): ?>
                		    <?php if ($order_status['order_status_id'] == $paysera_order_status_id): ?>
            				<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
            				<?php else: ?>
            				<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                			<?php endif; ?>
            			<?php endforeach; ?>
            			</select>
            		</td>
            	</tr>
            	<tr>
            		<td><?php echo $entry_geo_zone; ?></td>
            		<td>
                		<select name="paysera_geo_zone_id">
                			<option value="0"><?php echo $text_all_zones; ?></option>
                			<?php foreach ($geo_zones as $geo_zone): ?>
                    			<?php if ($geo_zone['geo_zone_id'] == $paysera_geo_zone_id): ?>
                    			<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
    	                        <?php else: ?>
                    			<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                    			<?php endif; ?>
                			<?php endforeach; ?>
                		</select>
            		</td>
            	</tr>
            	<tr>
            		<td width="25%"><?php echo $entry_status; ?></td>
            		<td>
            			<select name="paysera_status">
            		    <?php if ($paysera_status): ?>
            			<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            			<option value="0"><?php echo $text_disabled; ?></option>
            			<?php else: ?>
            			<option value="1"><?php echo $text_enabled; ?></option>
            			<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            			<?php endif; ?>
            			</select>
            		</td>
            	</tr>
            	<tr>
            		<td><?php echo $entry_default_payments; ?></td>
            		<td>
                		<select name="default_payment_country">
                		<?php foreach($payment_countries as $country ): ?>
                		    <?php if($country->getCode() == $default_payment_country): ?>
        						<option value="<?php echo $country->getCode(); ?>" selected="selected"><?php echo $country->getTitle(); ?></option>
        					<?php else: ?>
        						<option value="<?php echo $country->getCode(); ?>"><?php echo $country->getTitle(); ?></option>
        					<?php endif; ?>
    	                <?php endforeach; ?>
                		</select>
            		</td>
            	</tr>
            	<tr>
            		<td><?php echo $entry_display_payments; ?></td>
            		<td>
                		<select name="display_payments_list">
                			<?php if($display_payments_list == 1): ?>
                			<option value="1" selected="selected"><?php echo $text_yes; ?></option>
                			<option value="0"><?php echo $text_no; ?></option>
                			<?php else: ?>
                			<option value="1"><?php echo $text_yes; ?></option>
                			<option value="0" selected="selected"><?php echo $text_no; ?></option>
                			<?php endif; ?>
                		</select>
            		</td>
            	</tr>
            	<tr>
            		<td><?php echo $entry_sort_order; ?></td>
            		<td>
            			<input type="text" name="paysera_sort_order"value="<?php echo $paysera_sort_order; ?>" size="1" />
            		</td>
            	</tr>
            </table>
        </form>
    </div>
</div>

<form action="<?php echo $action; ?>" method="POST" id="refresh">
    <input type="text" name="refresh" value="1" style="display: none;" />
</form>

<?php echo $footer; ?>
