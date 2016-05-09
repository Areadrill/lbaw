<?php
include_once('../../config/init.php');
$smarty->assign('userid', $_GET['userid']);
$smarty->display();
?>
