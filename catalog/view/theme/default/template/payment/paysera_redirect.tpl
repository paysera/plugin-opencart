<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
    <form method="post" action="<?php echo $requestUrl; ?>" id="paysera">
    	<?php foreach($request as $key => $value): ?>
    	<input type="hidden" name="<?php echo $key; ?>" value="<?php echo $value; ?>" />
    	<?php endforeach; ?>
    </form>
    
    <script type="text/javascript">
    	onload = function () { 
    		document.getElementById('paysera').submit();
    	}
    </script>
</body>
</html>