<?php echo $header; ?><?php echo $column_left; ?>

<?php if ($error_warning): ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php endif; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-paysera" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
        </div>








    <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-paysera" class="form-horizontal">
            <div class="form-group required">
                <label class="col-sm-2 control-label" for="paysera_project"><?php echo $entry_project; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="paysera_project" value="<?php echo $paysera_project; ?>" class="form-control" />
                    <?php if ($error_project) { ?>
                    <div class="text-danger"><?php echo $error_project; ?></div>
                    <?php } ?>
                </div>
            </div>


            <div class="form-group required">
                <label class="col-sm-2 control-label" for="paysera_sign"><?php echo $entry_sign; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="paysera_sign" value="<?php echo $paysera_sign; ?>" class="form-control" />
                    <?php if ($error_sign) { ?>
                    <div class="text-danger"><?php echo $error_sign; ?></div>
                    <?php } ?>
                </div>
            </div>


            <div class="form-group required">
                <label class="col-sm-2 control-label" for="paysera_lang"><span data-toggle="tooltip" title="<?php echo $help_lang; ?>"><?php echo $entry_lang; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="paysera_lang" value="<?php echo $paysera_lang; ?>" class="form-control" />
                    <?php if ($error_lang) { ?>
                    <div class="text-danger"><?php echo $error_lang; ?></div>
                    <?php } ?>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="paysera_test"><?php echo $entry_test; ?></label>
                <div class="col-sm-10">
                    <select name="paysera_test" class="form-control">
                        <?php if($paysera_test == 0): ?>
                        <option value="0" selected="selected"><?php echo $text_off; ?></option>
                        <option value="100"><?php echo $text_on; ?></option>
                        <?php else: ?>
                        <option value="0"><?php echo $text_off; ?></option>
                        <option value="100" selected="selected"><?php echo $text_on; ?></option>
                        <?php endif;?>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-new-order-status"><?php echo $entry_new_order_status; ?></label>
                <div class="col-sm-10">
                    <select name="paysera_new_order_status_id" id="input-new-order-status" class="form-control">
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if ($order_status['order_status_id'] == $paysera_new_order_status_id) { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
                <div class="col-sm-10">
                    <select name="paysera_order_status_id" id="input-order-status" class="form-control">
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if ($order_status['order_status_id'] == $paysera_order_status_id) { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
                <div class="col-sm-10">
                    <select name="paysera_geo_zone_id" id="input-geo-zone" class="form-control">
                        <option value="0"><?php echo $text_all_zones; ?></option>
                        <?php foreach ($geo_zones as $geo_zone) { ?>
                        <?php if ($geo_zone['geo_zone_id'] == $paysera_geo_zone_id) { ?>
                        <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                    <select name="paysera_status" id="input-status" class="form-control">
                        <?php if ($paysera_status) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="paysera_display_payments_list"><?php echo $entry_display_payments; ?></label>
                <div class="col-sm-10">
                    <select name="paysera_display_payments_list" class="form-control">
                        <?php if($paysera_display_payments_list == 1): ?>
                        <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                        <option value="0"><?php echo $text_no; ?></option>
                        <?php else: ?>
                        <option value="1"><?php echo $text_yes; ?></option>
                        <option value="0" selected="selected"><?php echo $text_no; ?></option>
                        <?php endif; ?>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="paysera_sort_order" value="<?php echo $paysera_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                </div>
            </div>
        </form>
    </div>
</div>

    </div>
</div>

<?php echo $footer; ?>
