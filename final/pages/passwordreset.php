<?php
include_once('../config/init.php');
$smarty->assign('userid', $_GET['userid']);
$smarty->assign('uuid', $_GET['uuid']);
$smarty->display('templates/passwordrecovery.tpl');
?>
